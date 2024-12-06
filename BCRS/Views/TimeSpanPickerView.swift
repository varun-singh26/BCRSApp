//
//  TimeSpanPickerView.swift
//  BCRS
//
//  Created by Varun Singh on 12/5/24.
//

import SwiftUI

struct TimeSpanPickerView: View {
    let label: String
    @Binding var timeSpan: TimeSpan
    
    let yearRange = 2024...2030 //Customize as needed
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
            HStack {
                Picker("Month", selection: $timeSpan.month) {
                    ForEach(1...12, id: \.self) { month in
                        //
                        Text("\(month)").tag(month)
                    }
                }
                
                Picker("Day", selection: $timeSpan.day) {
                    ForEach(1...31, id: \.self) { day in
                        Text("\(day)").tag(day)
                    }
                }
                
                Picker("Year", selection: $timeSpan.year) {
                    ForEach(yearRange, id: \.self) { year in
                        Text("\(year)").tag(year)
                    }
                }
            }
        }
    }
}

#Preview {
    //Need to pass TimeSpanPickerView a Binding of a TimeSpan object
    struct TimeSpanPickerViewPreview: View {
        @State private var sampleTimeSpan = TimeSpan(month: 1, day: 1, year: 2024)
        
        var body: some View {
            TimeSpanPickerView(label: "Start Date", timeSpan: $sampleTimeSpan)
        }
    }
    
    return TimeSpanPickerViewPreview()
}
