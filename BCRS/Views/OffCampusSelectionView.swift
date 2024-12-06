//
//  OffCampusSelectionView.swift
//  BCRS
//
//  Created by Varun Singh on 12/4/24.
//

import SwiftUI


struct OffCampusSelectionView: View {
    @Binding var searchForm: SearchForm
    
    let classYears: [Int]
    let groupSizes: [Int]
    let numSeeks: [Int]
    
    var body: some View {
        VStack {
            PickerView(label: "Class Year:", selection: $searchForm.classYear, options: classYears)
            PickerView(label: "Group Size:", selection: $searchForm.numGroup, options: groupSizes)
            PickerView(label: "Number of Seekers:", selection: $searchForm.numSeek, options: numSeeks)
        }
    }
}


#Preview {
    @Previewable @State var searchForm = SearchForm(classYear: 2028, numGroup: 1, numSeek: 1, dorm: "")
    return OffCampusSelectionView(
        searchForm: $searchForm,
        classYears: [2028, 2027, 2026, 2025],
        groupSizes: [1, 2, 3, 4, 5],
        numSeeks: [1, 2, 3, 4]
    )
    //dorm is NOT an optional string now
}
