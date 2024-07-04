import Foundation
import Combine

class ComicsViewModel: ObservableObject {
    @Published var comics: [Comic] = []
    @Published var errorMessage: String?
    @Published var noResultsFound: Bool = false

    private var apiClient = MarvelAPIClient()
    private var cancellables = Set<AnyCancellable>()

    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                searchComicsByTitle(title: searchText)
            } else {
                comics = []
            }
        }
    }

    func fetchComics() {
        apiClient.fetchComics { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comics):
                    self?.comics = comics
                    self?.noResultsFound = comics.isEmpty
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func searchComicsByTitle(title: String) {
        apiClient.searchComicsByTitle(title: title) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comics):
                    self?.comics = comics
                    self?.noResultsFound = comics.isEmpty
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
