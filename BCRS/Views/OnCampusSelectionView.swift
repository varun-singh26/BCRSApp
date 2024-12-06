//
//  OnCampusSelectionView.swift
//  BCRS
//
//  Created by Varun Singh on 12/4/24.
//

import SwiftUI

struct OnCampusSelectionView: View {
    @Binding var searchForm: SearchForm
    
    
    let classYears: [Int]
    let groupSizes: [Int]
    let numSeeks: [Int]
    let dorms: [String]
    
    var body: some View {
        VStack {
            PickerView(label: "Class Year:", selection: $searchForm.classYear, options: classYears)
            PickerView(label: "Group Size:", selection: $searchForm.numGroup, options: groupSizes)
            PickerView(label: "Number of Seekers:", selection: $searchForm.numSeek, options: numSeeks)
            PickerView(label: "Desired Dorm:", selection: $searchForm.dorm, options: dorms)
        }
    }
}

#Preview {
    @Previewable @State var searchForm = SearchForm(classYear: 2028, numGroup: 1, numSeek: 1, dorm: "Ignacio Hall")
    return OnCampusSelectionView(
        searchForm: $searchForm,
        classYears: [2028, 2027, 2026, 2025],
        groupSizes: [1, 2, 3, 4, 5],
        numSeeks: [1, 2, 3, 4],
        dorms: ["Ninety St. Thomas More", "Vanderslice Hall", "Walsh Hall"]
    )
}
