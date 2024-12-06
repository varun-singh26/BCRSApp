import SwiftUI

struct TestView: View {
    var body: some View {
        Image(systemName: "bed.double.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.black)
    }
}

#Preview {
    TestView()
}
