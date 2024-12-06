//
//  BCRSApp.swift
//  BCRS
//
//  Created by Varun Singh on 12/3/24.
//

import SwiftUI
import SwiftData

@main
struct BCRSApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: Listing.self)
            
        }
    }
    
    //Will allow us to find where our simulator data is saved:
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
