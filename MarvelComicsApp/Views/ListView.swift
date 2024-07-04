import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ComicsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.comics, id: \.self) { comic in
                    ZStack {
                        NavigationLink(destination: ComicDetailView(comic: comic)) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0)
                        .opacity(0)
                        

                        ComicRowView(comic: comic)
                            .onAppear {
                                if comic == viewModel.comics.last {
                                    viewModel.fetchComics() // Load more comics when reaching the last one
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
