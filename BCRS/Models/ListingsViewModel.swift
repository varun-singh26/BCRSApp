//
//  ListingsViewModel.swift
//  BCRS
//
//  Created by Varun Singh on 12/3/24.
//

import Foundation


struct TimeSpan: Codable {
    var month: Int
    var day: Int
    var year: Int
}

struct Period: Codable {
    var start: TimeSpan
    var end: TimeSpan
}

struct Member: Codable, Hashable {
    var name: String
    var academicYear: String
}

struct ImageType: Codable {
    var src: String
    var alt: String
}

struct offCampusListing: Codable, Identifiable { //Make listing conform to Identifiable Protocol
    var id: Int
    var numGroup: Int
    var numSeek: Int
    var rent: Int
    var utilities: String //just in case any filed is null or missing in future data
    var period: Period
    var address: String
    var image: ImageType
    var members: [Member]
    var listingLocation: String
}

struct onCampusListing: Codable, Identifiable { //Make listing conform to Identifiable Protocol
    var id: Int
    var numGroup: Int
    var numSeek: Int
    var aim: String
    var dorm: String
    var image: ImageType
    var members: [Member]
    var listingLocation: String
}


struct Returned: Codable {
    var onCampusListings: [onCampusListing]
    var offCampusListings: [offCampusListing]
    
    enum CodingKeys: String, CodingKey {
        case onCampusListings = "oncampus"
        case offCampusListings = "offcampus"
    }
}


@MainActor
@Observable
class ListingsViewModel {
    
    //attributes of this class
    //All are intially empty before data is fetched
    var onCampusListings: [onCampusListing] = []
    var offCampusListings: [offCampusListing] = []
    
    func loadLocalJSON() async {
        guard let url = Bundle.main.url(forResource: "db", withExtension: "json") else {
            print("😡 ERROR: Could not find db.json in the project with specified path")
            return
        }
        print("url of local data: \(url)")
        
        do {
            // Load the file contents into a Data object
            let data = try? Data(contentsOf: url)
            //print(data!)
            print(data!.count)
            
            if let jsonString = String(data: data!, encoding: .utf8) {
                //print("JSON String: \(jsonString)")
            }
                
            // Decode the JSON data into the `Returned` struct
            let returned = try JSONDecoder().decode(Returned.self, from: data!)
            
            Task { @MainActor in
                // Assign values to properties
                self.onCampusListings = returned.onCampusListings
                self.offCampusListings = returned.offCampusListings
                
                print("😁 SUCCESS: Local JSON loaded successfully")
                print("onCampusListings:")
                print("\(onCampusListings.count) Listings were returned")
                //print("\(onCampusListings)")
                print("-------------------------------------------------")
                print("offCampusListings:")
                print("\(offCampusListings.count) Listings were returned")
                //print("\(offCampusListings)")
            }
        } catch {
            print("ERROR: Could not decode local JSON - \(error.localizedDescription)")
        }
    }
    
}

extension ListingsViewModel {
    @MainActor
    func loadPreviewData() {
        self.offCampusListings = [
            offCampusListing(
                id: 1,
                numGroup: 6,
                numSeek: 3,
                rent: 1200,
                utilities: "Included",
                period: Period(
                    start: TimeSpan(month: 3, day: 1, year: 2025),
                    end: TimeSpan(month: 6, day: 30, year: 2025)
                ),
                address: "123 Example Address",
                image: ImageType(src: "example.jpg", alt: "Example Image"),
                members: [Member(name: "Harim", academicYear: "Wang")],
                listingLocation: "offcampus"
            )
        ]
        
        self.onCampusListings = [
            onCampusListing(
                id: 1,
                numGroup: 6,
                numSeek: 3,
                aim: "9-man housing",
                dorm: "Ignacio Hall",
                image: ImageType(src: "example.jpg", alt: "Example Image"),
                members: [Member(name: "Harim", academicYear: "Wang")],
                listingLocation: "oncampus"
            )
        ]
    }
}

