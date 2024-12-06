//
//  PickerView.swift
//  BCRS
//
//  Created by Varun Singh on 12/4/24.
//

import SwiftUI

struct PickerView<T: Hashable>: View {
    let label: String //The label that is passed (ie. "Class Year")
    @Binding var selection: T //The type of the selection variable (ie. String for listing location, Int for class year)
                            // Two-way binding to the current selection variable. Changes made in the picker will update the bound variable in the parent view and vice-versa
    
    let options: [T]    //An array of selectable options of Type T
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            Picker(selection: $selection, label: Text("Select One")) {
                ForEach(options, id: \.self) { option in
                    Text("\(option)")
                }
            }
            //prints to console the new value of a selection (Binding Variable) that was changed via the picker
            .onChange(of: selection) { newValue in
                print("\(label) property of form updated with new value: \(newValue)")
                print("New value of \(label) property from form is: \(selection) ")
                
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    @Previewable @State var selectedOption: Int = 2028 //I have no idea what @Previewable does
    return PickerView(
        label: "Class Year",
        selection: $selectedOption,
        options: [2028, 2027, 2026, 2025]
    )
}

