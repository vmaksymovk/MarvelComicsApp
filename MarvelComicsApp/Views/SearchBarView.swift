import SwiftUI

struct SearchBarView: View {
    @StateObject private var viewModel = ComicsViewModel()
    @State private var selectedComic: Comic? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.noResultsFound && !viewModel.searchText.isEmpty {
                    VStack {
                        
                        ContentUnavailableView("", systemImage: "exclamationmark.magnifyingglass", description: Text("There is no comic book with that name in our library. Check the spelling and try again."))
                            
                        
                    }
                }
                List(viewModel.comics, id: \.self) { comic in
                    ComicRowView(comic: comic)
                        .onTapGesture {
                            selectedComic = comic
                        }
                        .navigationDestination(
                            isPresented: Binding(
                                get: { selectedComic == comic },
                                set: { newValue in
                                    if !newValue {
                                        selectedComic = nil
                                    } else {
                                        selectedComic = comic
                                    }
                                }
                            )
                        ) {
                            ComicDetailView(comic: comic)
                        }
                }
                .searchable(text: $viewModel.searchText)
                .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
                }
                
                
            }
        }
    }
}

#Preview {
    SearchBarView()
}
