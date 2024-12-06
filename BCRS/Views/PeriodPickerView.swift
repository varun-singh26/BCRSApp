//
//  PeriodPickerView.swift
//  BCRS
//
//  Created by Varun Singh on 12/5/24.
//

import SwiftUI

struct PeriodPickerView: View {
    @Binding var period: Period
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select Period:")
                .font(.headline)
            
            TimeSpanPickerView(label: "Start Date", timeSpan: $period.start)
            TimeSpanPickerView(label: "End Date", timeSpan: $period.end)
        }
    }
}

#Preview {
    struct PeriodPickerViewPreview: View {
        @State private var samplePeriod: Period = Period(start: TimeSpan(month: 1, day: 1, year: 2024), end: TimeSpan(month: 12, day: 31, year: 2024))
        
        var body: some View {
            PeriodPickerView(period: $samplePeriod)
        }
    }
    
    return PeriodPickerViewPreview()
}
