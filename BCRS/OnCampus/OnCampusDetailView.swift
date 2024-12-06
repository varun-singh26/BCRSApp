//
//  OnCampusDetailView.swift
//  BCRS
//
//  Created by Varun Singh on 12/3/24.
//

import SwiftUI

struct OnCampusDetailView: View {
    @State var onCampusListing : onCampusListing
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(onCampusListing.image.src)
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
                    ForEach(onCampusListing.members, id: \.self) { member in
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
                    Text("\(onCampusListing.numSeek)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("more")
                }
                .padding(.leading, 50)
            }
            
            VStack (alignment: .leading) {
                Text("Dorm:")
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(onCampusListing.dorm)")
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
        OnCampusDetailView(onCampusListing: onCampusListing(
            id: 1,
            numGroup: 3,
            numSeek: 2,
            aim: "6-man housing",
            dorm: "Ignacio Hall",
            image: ImageType(src: "ignacio", alt: "Example"),
            members: [Member(name: "Rachel Smith", academicYear: "Senior"), Member(name: "Ricardo Grillo", academicYear: "Senior"), Member(name: "Harim Wang", academicYear: "Senior"), Member(name: "Andy Smith", academicYear: "Junior")],
            listingLocation: "oncampus"
        ))
    }
}



