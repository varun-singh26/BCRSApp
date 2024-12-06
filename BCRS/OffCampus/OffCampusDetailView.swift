//
//  OffCampusDetailView.swift
//  BCRS
//
//  Created by Varun Singh on 12/3/24.
//

import SwiftUI

struct OffCampusDetailView: View {
    @State var offCampusListing : offCampusListing
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(offCampusListing.image.src)
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
                    ForEach(offCampusListing.members, id: \.self) { member in
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
                    Text("\(offCampusListing.numSeek)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("more")
                }
                .padding(.leading, 50)
            }
            
            VStack (alignment: .leading){
                Text("Lease Timeline:")
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Text("Start Date:")
                    Text("\(offCampusListing.period.start.month)/\(offCampusListing.period.start.day)/\(offCampusListing.period.start.year)")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("End Date:")
                    Text("\(offCampusListing.period.end.month)/\(offCampusListing.period.end.day)/\(offCampusListing.period.end.year)")
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
                    Text("\(offCampusListing.address)")
                }
                VStack (alignment: .leading) {
                    Text("Expense Info:")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Rent: $\(offCampusListing.rent)")
                    Text("Utilities: \(offCampusListing.utilities)")
                }
                .padding(.top, 2)
            }
            .padding(.top, 25)
            .padding(.horizontal, 15)

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
        OffCampusDetailView(offCampusListing: offCampusListing(
            id: 1,
            numGroup: 3,
            numSeek: 2,
            rent: 1200,
            utilities: "Included",
            period: Period(start: TimeSpan(month: 2, day: 15, year: 2025), end: TimeSpan(month: 6, day: 30, year: 2025)),
            address: "2035 Commonwealth Avenue",
            image: ImageType(src: "1335 Boylston St", alt: "Example"),
            members: [Member(name: "Rachel Smith", academicYear: "Senior"), Member(name: "Ricardo Grillo", academicYear: "Senior"), Member(name: "Harim Wang", academicYear: "Senior"), Member(name: "Andy Smith", academicYear: "Junior")],
            listingLocation: "offcampus"
        ))
    }
}


