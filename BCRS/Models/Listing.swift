//
//  Listings.swift
//  BCRS
//
//  Created by Varun Singh on 12/5/24.
//

import Foundation
import SwiftData

@MainActor
@Model
class Listing {
    //var id: Int     //We are not using ID property for instance of the Listing Class
    var numGroup: Int
    var numSeek: Int
    var aim: String? // For on-campus listings
    var dorm: String? // For on-campus listings
    var address: String? // For off-campus listings
    var rent: Int? // For off-campus listings
    var utilities: String? // For off-campus listings
    var period: Period? // For off-campus listings
    var members: [Member]
    var imageSrc: String
    var listingLocation: String // "oncampus" or "offcampus"
    
    init(numGroup: Int, numSeek: Int, aim: String? = nil, dorm: String? = nil, address: String? = nil, rent: Int? = nil, utilities: String? = nil, period: Period? = nil, members: [Member], imageSrc: String, listingLocation: String) {
            self.numGroup = numGroup
            self.numSeek = numSeek
            self.aim = aim
            self.dorm = dorm
            self.address = address
            self.rent = rent
            self.utilities = utilities
            self.period = period
            self.members = members
            self.imageSrc = imageSrc
            self.listingLocation = listingLocation
        }
}

extension Listing {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Listing.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(Listing(numGroup: 4, numSeek: 2, address: "1335 Boylston Street, Boston, MA 02215", rent: 900, utilities: "Not Included", period: Period(start: TimeSpan(month: 9, day: 10, year: 2025), end: TimeSpan(month: 12, day: 12, year: 2025)), members: [Member(name: "John Doe", academicYear: "Junior"), Member(name: "Varun Singh", academicYear: "Junior")], imageSrc: "1335 Boylston St", listingLocation: "offcampus"))
        container.mainContext.insert(Listing(numGroup: 8, numSeek: 3, aim: "8-man housing", dorm: "Ignacio Hall", period: Period(start: TimeSpan(month: 8, day: 10, year: 2025), end: TimeSpan(month: 5, day: 13, year: 2026)), members: [Member(name: "Paul White", academicYear: "Junior"), Member(name: "James Drake", academicYear: "Junior"), Member(name: "Kyle Samford", academicYear: "Junior"), Member(name: "Bill Stephens", academicYear: "Junior"), Member(name: "Max Couffey", academicYear: "Junior")], imageSrc: "ignacio", listingLocation: "oncampus"))
        
        return container
    }
}


