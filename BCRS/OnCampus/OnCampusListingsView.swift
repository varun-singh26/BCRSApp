//
//  ListingsView.swift
//  BCRS
//
//  Created by Varun Singh on 12/3/24.
//

import SwiftUI

struct OnCampusListingsView: View {
    @State var searchForm : SearchForm
    @State var listingsVM : ListingsViewModel = ListingsViewModel()
    @State private var filteredListings: [onCampusListing] = []

    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        NavigationStack {
            List(filteredListings) { onCampusListing in
                LazyVStack(alignment: .leading) {
                    NavigationLink {
                        OnCampusDetailView(onCampusListing: onCampusListing)
                    } label: {
                        VStack (alignment: .leading) {
                            HStack {
                                Image(onCampusListing.image.src)
                                    .resizable()
                                    .scaledToFit()
                                    .border(Color("Color1"), width: 3)
                                    .shadow(color: .gray, radius: 5)
                                Spacer()
                                Text("Looking for \(onCampusListing.numSeek)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.top, 32) //Keeps text inline with arrow
                                    .padding(.leading, 10)
                            }
                            HStack {
                                Image("location")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(onCampusListing.dorm)
                                Spacer()
                                Image("bed")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("\(onCampusListing.numGroup) People Total")
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Matching Listings")
            .navigationBarBackButtonHidden()
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
            print("In OnCampusListingsView")
            print("Here is the passed search form:")
            print("searchForm: \(searchForm)")
        }
    }
    
    @MainActor //Execute this async function on the Main Thread
    private func loadFilteredListings() async {
        
        await listingsVM.loadLocalJSON() //onCampusListings of VM is only intitialize when loadLocalJSON() method is run
        
        //simulate asynchronous delay (1 second)
        try! await Task.sleep(nanoseconds: 1_000_000_000)
        
        
        print("\n")
        //print("printing all onCampusListings:")
        //print("\n")
        //print("\(listingsVM.onCampusListings)")
        //print("\n")
        //print("printing each listing in offCampusListings:")
        //print("\n")
        /*listingsVM.onCampusListings.forEach { print("\($0)\n")
        }*/
        
        //filter the onCampus listings to match search criteria //after JSON is loaded into listingsVM
        filteredListings = listingsVM.onCampusListings.filter { onCampusListing in
            onCampusListing.numGroup == searchForm.numGroup || onCampusListing.numSeek == searchForm.numSeek || onCampusListing.dorm == searchForm.dorm
        }
        print("Filtered onCampus Listings Count: \(filteredListings.count)")
            for onCampusListing in filteredListings {
                print("Listing: \(onCampusListing)")
            }
    }
}

#Preview {
    let previewVM = ListingsViewModel()
    //load the preview data for OnCampusListingsView
    previewVM.loadPreviewData()
    return OnCampusListingsView(searchForm: SearchForm(classYear: 2028, numGroup: 6, numSeek: 3, dorm: "Ignacio Hall"), listingsVM: previewVM)
    //BE CAREFUL TO MAKE SURE DORM NAMES inputed in the search form match those in the JSON file
}



