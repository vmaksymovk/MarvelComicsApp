import SwiftUI


struct ListView: View {
    @StateObject private var viewModel = ComicsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.comics, id: \.self) { comic in
                    NavigationLink(destination: ComicDetailView(comic: comic)) {
                        ComicRowView(comic: comic)
                            .onAppear {
                                if comic == viewModel.comics.last {
                                    viewModel.fetchComics() 
                                }
                            }
                    }
                }
                .navigationTitle("Marvel Comics")
                .onAppear {
                    viewModel.fetchComics()
                }
                .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
                }
                
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
