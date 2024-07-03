import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.078, green: 0.18, blue: 0.38, alpha: 1)), Color(#colorLiteral(red: 0.11, green: 0.24, blue: 0.49, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            
            Image("Shield")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 273.1, height: 263.52)
        }
    }
}

#Preview {
    SplashScreen()
}
