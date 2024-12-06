//
//  ListingsView.swift
//  BCRS
//
//  Created by Varun Singh on 12/3/24.
//

import SwiftUI

struct OffCampusListingsView: View {
    @State var searchForm : SearchForm
    @State var listingsVM : ListingsViewModel = ListingsViewModel()
    @State private var filteredListings: [offCampusListing] = []
    
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        NavigationStack {
            List(filteredListings) { offCampusListing in
                LazyVStack(alignment: .leading) {
                    NavigationLink {
                        OffCampusDetailView(offCampusListing: offCampusListing)
                    } label: {
                        VStack (alignment: .leading) {
                            HStack {
                                Image(offCampusListing.image.src)
                                    .resizable()
                                    .scaledToFit()
                                    .border(Color("Color1"), width: 3)
                                    .shadow(color: .gray, radius: 5)
                                Spacer()
                                Text("Looking for \(offCampusListing.numSeek)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.top, 32) //Keeps text inline with arrow
                                    .padding(.leading, 10)
                            }
                            HStack {
                                Image("location")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(offCampusListing.address)
                                Spacer()
                                Image("bed")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("\(offCampusListing.numGroup) People Total")
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Matching Listings")
            .navigationBarBackButtonHidden() //goes INSIDE the last curly of the NavigationStack
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Load All") {
                        Task {
                            //TODO:
                            //implement listingsVM.loadAll();
                        }
                    }
                }
                ToolbarItem(placement: .status) {
                    Text("")
                }
            }
        }
        .task { @MainActor in //task is an async version of onChange. Runs right when the view appears
            await loadFilteredListings()
        }
        .onAppear {
            print("In OffCampusListingsView")
            print("Here is the passed search form:")
            print("searchForm: \(searchForm)")
        }
    }
    
    @MainActor //Execute this async function on the Main Thread
    private func loadFilteredListings() async {
        await listingsVM.loadLocalJSON() //offCampusListings of VM is only intitialize when loadLocalJSON() method is run
        
        //simulate asynchronous delay (1 second)
        try! await Task.sleep(nanoseconds: 1_000_000_000)
        
        print("\n")
        //print("printing all offCampusListings:")
        //print("\n")
        //print("\(listingsVM.offCampusListings)")
        //print("\n")
        //print("printing each listing in offCampusListings:")
        //print("\n")
        /*listingsVM.offCampusListings.forEach { print("\($0)\n")
        }*/
        
        //filter the offCampus listings to match search criteria //after JSON is loaded into listingsVM
        filteredListings = listingsVM.offCampusListings.filter { offCampusListing in
            offCampusListing.numGroup == searchForm.numGroup || offCampusListing.numSeek == searchForm.numSeek
        }
        print("Filtered offCampus Listings Count: \(filteredListings.count)")
            for offCampusListing in filteredListings {
                print("Listing: \(offCampusListing)")
            }
    }
}

#Preview {
    let previewVM = ListingsViewModel()
    //load the preview data for OffCampusListingsView
    previewVM.loadPreviewData()
    return OffCampusListingsView(searchForm: SearchForm(classYear: 2028, numGroup: 6, numSeek: 3, dorm: ""), listingsVM: previewVM)
    //dorm is NOT an optional string now
}
