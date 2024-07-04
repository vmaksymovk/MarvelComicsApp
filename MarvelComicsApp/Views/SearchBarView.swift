import SwiftUI

struct SearchBarView: View {
    @StateObject private var viewModel = ComicsViewModel()
    @State private var selectedComic: Comic? = nil

    var body: some View {
        NavigationStack {
            VStack {
                
                if viewModel.searchText.isEmpty {
                    VStack {
                        ContentUnavailableView {
                            Label("", systemImage: "book.fill")
                                .frame(width: 80, height: 62)
                                .labelsHidden()
                        } description: {
                            Text("Start typing to find a particular comic.")
                                .bold()
                        }
                    }
                }
                
                
                else if viewModel.noResultsFound {
                    VStack {
                        ContentUnavailableView {
                            Label("", systemImage: "exclamationmark.magnifyingglass")
                                .frame(width: 62, height: 62)
                                .labelsHidden()
                        } description: {
                            Text("There is no comic book with that name in our library. Check the spelling and try again.")
                                .bold()
                        }
                    }
                }
                
                
                else if viewModel.isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(RedProgressViewStyle())
                            
                    }
                }
                
                
                else {
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
                }
            }
            .searchable(text: $viewModel.searchText)
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    SearchBarView()
}
