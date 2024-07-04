import SwiftUI

struct RedProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .progressViewStyle(CircularProgressViewStyle(tint: .red))
            .scaleEffect(2)
    }
}
