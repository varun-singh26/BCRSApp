//
//  SearchButtonView.swift
//  BCRS
//
//  Created by Varun Singh on 12/4/24.
//

import SwiftUI

struct SearchButtonView: View {
    @Binding var showFullScreenCover: Bool //need to pass showFullScreenCover as a @Binding var so the child view, SearchButtonView, can modify the value in the parent view
        //@Binding needed because child view modifies the parent's (HomeView) state (via changing this variable), without owning the state of the variable. A TWO-way connection is established with @Binding
        //If the child used its own @State instead of @Binding, any updates would be local to the child and wouldn’t affect the parent.
    var body: some View {
        Button {
            showFullScreenCover = true
        } label: {
            Text("Search")
        }
        .buttonStyle(.borderedProminent)
        .tint(.accentColor)
    }
}

#Preview {
    @Previewable @State var showFullScreenCover = false
    return SearchButtonView(showFullScreenCover: $showFullScreenCover)
}


