//
//  PostingFormView.swift
//  BCRS
//
//  Created by Varun Singh on 12/5/24.
//

import SwiftUI
import SwiftData

struct PostingFormView: View {
    @State var listing : Listing //All attributes of this passed listing are empty to start
    
    //Create Local variables for this view
    //We will the assign the past Listing object with these vars
    
    //non optional vars of Listing Object
    @State private var numGroup = 2
    @State private var numSeek = 1
    @State private var members: [Member] = []
    @State private var imageSrc: String = ""
    @State private var listingLocation: String = ""
    
    //optional vars of Listing Object
    @State private var aim: String? = ""
    @State private var dorm: String? = ""
    @State private var address: String? = ""
    @State private var rent: Int? = 0
    @State private var utilities: String? = ""
    @State private var period: Period? = nil
    
    
    //Initialize options for form fields
    let locations = ["Select One", "oncampus", "offcampus"]
    //Not going to implement Select One for these options yet
    let classYears = [ "Freshman", "Sophomore", "Junior", "Senior"]
    let groupSizes = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let numSeeks = [1, 2, 3, 4, 5, 6, 7, 8]
    let dorms = ["Ninety St. Thomas More", "Vanderslice Hall", "Thomas More Apartments", "Rubenstein Hall", "Voute Hall", "Walsh Hall"]
    let utilitiesOptions = ["Include", "Not Included"]
    
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        List {
            
            PickerView(label: "Listing Location:", selection: $listingLocation, options: locations)
            
            PickerView(label: "Size of Total Group:", selection: $numGroup, options: groupSizes)
            
            PickerView(label: "Number of People Looking For:", selection: $numSeek, options: numSeeks )
            
            ForEach(0..<(numGroup - numSeek), id: \.self) { i in
                VStack {
                    TextField("Enter Member \(i + 1) Name:", text: Binding(get: {members.indices.contains(i) ? members[i].name : ""}, set: { newValue in
                        if members.indices.contains(i) {
                            members[i].name = newValue
                        }
                    }
                                                                          ))
                    PickerView(label: "Member \(i + 1) Class Year", selection: Binding (get: {members.indices.contains(i) ? members[i].academicYear : ""}, set: { newValue in
                        if members.indices.contains(i) {
                            members[i].academicYear = newValue
                        }
                    }), options: classYears)
                }
            }
            
            if (listingLocation == "offcampus") {
                TextField("Enter listing address:", text: Binding(get: {
                    address ?? ""
                }, set: { address = $0.isEmpty ? nil : $0}))
                
                
                Text("Are utilities included?")
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                    .padding(.top, 5)
                
                Picker("Are utilites included?", selection: Binding(get: {
                    utilities ?? "Not Included"
                }, set: { newValue in utilities = newValue})) {
                    Text("Included").tag("Included")
                    Text("Not Included").tag("Not Included")
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text("Monthly Rent Cost (per person):")
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                    .padding(.top, 5)
                
                TextField("Enter Rent", text: Binding (get: {
                    rent == nil ? "" : String(rent!)
                }, set: { newValue in
                    if let value = Int(newValue) {
                        rent = value
                    } else if newValue.isEmpty { //newValue is what's inputted into Text Field
                        rent = nil //Handle empty input as nil
                    }
                }))
                .keyboardType(.numberPad) //Keyboard shows numbers only
                
                
                PeriodPickerView(period: Binding(
                    get: { period ?? Period(start: TimeSpan(month: 1, day: 1, year: 2025), end: TimeSpan(month: 12, day: 31, year: 2025))},
                    set: { newValue in period = newValue }
                    ))
                
            } else if (listingLocation == "oncampus") {
                Picker("Select Dorm:", selection: Binding(
                        get: { dorm ?? "Walsh Hall" },
                        set: { newValue in dorm = newValue }
                    )) {
                        Text("Walsh Hall").tag("Walsh Hall")
                        Text("Voute Hall").tag("Voute Hall")
                        Text("Thomas More Apartments").tag("Thomas More Apartments")
                        Text("Rubenstein Hall").tag("Rubenstein Hall")
                        Text("Vanderslice Hall").tag("Vanderslice Hall")
                        Text("Ninety St. Thomas More").tag("Ninety St. Thomas More")
                    }
                    .pickerStyle(MenuPickerStyle()) // Optional, for a dropdown menu style
                    .padding(.top, 5)
                
                // Automatically set aim based on numGroup
                    Text("Aim: \(aim ?? "")")
                        .onChange(of: numGroup) { newValue in
                            switch newValue {
                            case 2: aim = "2-man housing"
                            case 3: aim = "3-man housing"
                            case 4: aim = "4-man housing"
                            case 5: aim = "5-man housing"
                            case 6: aim = "6-man housing"
                            case 7: aim = "7-man housing"
                            case 8: aim = "8-man housing"
                            case 9: aim = "9-man housing"
                            default: aim = ""
                            }
                        }

            }
            
        }
        .listStyle(.plain)
        .onAppear { //as soon as PostingFormView appears, assign the NON-OPTIONAL local variables of its interface with the fields in the Listing object that was passed from the parent view (MyPostingsView)
            numGroup = listing.numGroup
            numSeek = listing.numSeek
            members = listing.members
            imageSrc = listing.imageSrc
            listingLocation = listing.listingLocation
            
            //Populate local members array to ensure it has the right number of elements
            while members.count < (numGroup - numSeek) {
                members.append(Member(name: "", academicYear: ""))
            }
            
            listingLocation = listing.listingLocation
            
            //period starts out as nil. So we want to assign a default value when the user first sees this view
            if period == nil {
                period = Period(start: TimeSpan(month: 1, day: 1, year: 2025), end: TimeSpan(month: 12, day: 31, year: 2025))
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    //move data from local vars of this interface to Listing object
                    listing.numGroup = numGroup
                    listing.numSeek = numSeek
                    listing.members = members
                    listing.imageSrc = imageSrc
                    listing.listingLocation = listingLocation
                    //Optionals
                    listing.aim = aim
                    listing.dorm = dorm
                    listing.address = address
                    listing.rent = rent
                    listing.utilities = utilities
                    listing.period = period
                    
                    //Save code:
                    modelContext.insert(listing)
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: Save on PostingFormView did not work")
                        return
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PostingFormView(listing: Listing(numGroup: 5, numSeek: 1, members: [], imageSrc: "bookmark-white", listingLocation: ""))
            .modelContainer(for: Listing.self, inMemory: true)
    }
}
