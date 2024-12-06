//
//  MyPostingsView.swift
//  BCRS
//
//  Created by Varun Singh on 12/5/24.
//

import SwiftUI
import SwiftData

struct MyPostingsView: View {
    
    @Query var listingsA : [Listing]
    @Environment(\.modelContext) var modelContext //To use the query property, our View needs to also refer to the model context
    
    @Environment(\.dismiss) var dismiss
    
    @State private var sheetIsPresented = false //Determines if empty DetailView is presented
    
    
    /*var listings : [Listing] = [Listing(numGroup: 4, numSeek: 2, address: "1335 Boylston Street, Boston, MA 02215", rent: 900, utilities: "Not Included", period: Period(start: TimeSpan(month: 9, day: 10, year: 2025), end: TimeSpan(month: 12, day: 12, year: 2025)), members: [Member(name: "John Doe", academicYear: "Junior"), Member(name: "Varun Singh", academicYear: "Junior")], imageSrc: "1335 Boylston St", listingLocation: "offcampus"),
        
        Listing(numGroup: 8, numSeek: 3, aim: "8-man housing", dorm: "Walsh Hall", period: Period(start: TimeSpan(month: 8, day: 10, year: 2025), end: TimeSpan(month: 5, day: 13, year: 2026)), members: [Member(name: "Paul White", academicYear: "Junior"), Member(name: "James Drake", academicYear: "Junior"), Member(name: "Kyle Samford", academicYear: "Junior"), Member(name: "Bill Stephens", academicYear: "Junior"), Member(name: "Max Couffey", academicYear: "Junior")], imageSrc: "walsh", listingLocation: "oncampus")]*/
    
    var body: some View {
        
        NavigationStack {
            List(listingsA) { listing in
                LazyVStack(alignment: .leading) {
                    NavigationLink {
                        DetailView(listing: listing)
                    } label: {
                        VStack (alignment: .leading) {
                            HStack {
                                Image(listing.imageSrc)
                                    .resizable()
                                    .scaledToFit()
                                    .border(Color("Color1"), width: 3)
                                    .shadow(color: .gray, radius: 5)
                                Spacer()
                                Text("Looking for \(listing.numSeek)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.top, 32) //Keeps text inline with arrow
                                    .padding(.leading, 10)
                            }
                            HStack {
                                Image("location")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                if (listing.listingLocation == "oncampus") {
                                    Text(listing.dorm!)
                                } else if (listing.listingLocation == "offcampus") {
                                    Text(listing.address!)
                                }
                                Spacer()
                                Image("bed")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("\(listing.numGroup) People Total")
                            }
                        }
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(listing)
                            guard let _ = try? modelContext.save() else {
                                print("😡 ERROR: Save after DELETE on MyPostingsView did not work.")
                                return
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Postings")
            //.navigationBarTitleDisplayMode(.automatic) What does this do?
            .navigationBarBackButtonHidden() //goes INSIDE the last curly of the NavigationStack
            .fullScreenCover(isPresented: $sheetIsPresented) {
                NavigationStack {
                    PostingFormView(listing: Listing(numGroup: 1, numSeek: 1, members: [], imageSrc: "bookmark-white", listingLocation: ""))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    //Save Button
                    Button {
                        sheetIsPresented.toggle() //set sheetIsPresented to true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    MyPostingsView()
        .modelContainer(Listing.preview)
}
