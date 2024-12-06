//
//  DetailView.swift
//  BCRS
//
//  Created by Varun Singh on 12/5/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @State var listing : Listing
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(listing.imageSrc)
                .resizable()
                .scaledToFit()
                .shadow(color: .gray, radius: 5)
                .padding(.horizontal, 15)
            
            HStack {
                VStack (alignment: .center) {
                    HStack {
                        Image("group")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Group:")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    ForEach(listing.members, id: \.self) { member in
                        HStack {
                            Text("\(member.name),")
                                .fontWeight(.bold)
                            Text("\(member.academicYear)")
                        }
                        
                    }
                    //.listStyle(.plain)
                }
                .padding(.horizontal, 15)
                
                VStack {
                    Text("Seeking:")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(listing.numSeek)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("more")
                }
                .padding(.leading, 50)
            }
            
            if (listing.listingLocation == "oncampus") {
                VStack (alignment: .leading) {
                    Text("Dorm:")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(listing.dorm ?? "")")
                }
                .padding(.top, 25)
                .padding(.horizontal, 15)
            } else if (listing.listingLocation == "offcampus") {
                VStack (alignment: .leading){
                    Text("Lease Timeline:")
                        .font(.title)
                        .fontWeight(.bold)
                    HStack {
                        Text("Start Date:")
                        Text("\(listing.period!.start.month)/\(listing.period!.start.day)/\(listing.period!.start.year)")
                            .fontWeight(.bold)
                    }
                    HStack {
                        Text("End Date:")
                        Text("\(listing.period!.end.month)/\(listing.period!.end.day)/\(listing.period!.end.year)")
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 25)
                .padding(.horizontal, 15)

                
                VStack (alignment: .leading) {
                    VStack (alignment: .leading) {
                        Text("Address:")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("\(listing.address!)")
                    }
                    VStack (alignment: .leading) {
                        Text("Expense Info:")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Rent: $\(listing.rent!)")
                        Text("Utilities: \(listing.utilities!)")
                    }
                    .padding(.top, 2)
                }
                .padding(.top, 25)
                .padding(.horizontal, 15)

            }
            
                        
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    //TODO: add bookmark listing here code here
                } label: {
                    Image("") //TODO: add bookmark Image here
                }

            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(listing: Listing(numGroup: 8, numSeek: 3, aim: "8-man housing", dorm: "Walsh Hall", period: Period(start: TimeSpan(month: 8, day: 10, year: 2025), end: TimeSpan(month: 5, day: 13, year: 2026)), members: [Member(name: "Paul White", academicYear: "Junior"), Member(name: "James Drake", academicYear: "Junior"), Member(name: "Kyle Samford", academicYear: "Junior"), Member(name: "Bill Stephens", academicYear: "Junior"), Member(name: "Max Couffey", academicYear: "Junior")], imageSrc: "walsh", listingLocation: "oncampus"))
    }
}
