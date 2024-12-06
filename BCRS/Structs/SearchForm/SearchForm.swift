//
//  SearchForm.swift
//  BCRS
//
//  Created by Varun Singh on 12/3/24.
//

import Foundation
import Observation


//Only using the SearchForm struct as of right now
@MainActor
//@Observable
struct SearchForm {
    var classYear: Int
    var numGroup: Int
    var numSeek: Int
    var dorm: String //Only for on-campus listings, but keep as non-optional for now
}


@MainActor
@Observable
class FormManager {
    static let sharedForm = FormManager() //Singleton Instance. Only one form will be use/read from to filter listing during an app session
    
    private init() { // Private initializer to prevent external instantiation
        form = SearchForm(classYear: 2028, numGroup: 1, numSeek: 1, dorm: "Select One")
    }
    
    var form: SearchForm // Non-optional since form is always intialized
}
 
    



