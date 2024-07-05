import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ComicsViewModel()  // Initializes view model
    
    var body: some View {
        NavigationStack {  // Container for navigation-related views
            ZStack {
                List(viewModel.comics, id: \.self) { comic in  // Lists comics
                    ZStack {
                        NavigationLink(destination: ComicDetailView(comic: comic)) {
                            EmptyView()  // Invisible placeholder for navigation
                        }
                        .buttonStyle(PlainButtonStyle())  
                        
                        ComicRowView(comic: comic)  // Renders each comic row
                            .onAppear {
                                if comic == viewModel.comics.last {
                                    viewModel.fetchComics()  // Loads more comics when last one appears
                                }
                            }
                    }
                }
                .navigationTitle("Marvel Comics")
                .onAppear {
                    viewModel.fetchComics()  // Fetches initial comics
                }
                .alert(isPresented: .constant(viewModel.errorMessage != nil)) {  // Shows alert if there's an error
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
                }
                
                // Progress View shown when loading more comics
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
    }
}
#Preview {
    ListView()
}
