import Foundation
import Combine

class ComicsViewModel: ObservableObject {
    @Published var comics: [Comic] = []
    @Published var errorMessage: String?
    @Published var noResultsFound: Bool = false
    @Published var isLoading: Bool = false
    private var apiClient = MarvelAPIClient()
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage = 0
    private var totalResults = 0
    private var isFetching = false
    private let pageSize = 20

    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                currentPage = 0
                comics = []
                searchComicsByTitle(title: searchText)
            } else {
                comics = []
                noResultsFound = false
            }
        }
    }

    func fetchComics() {
        guard !isFetching else { return }
        isFetching = true
        
        apiClient.fetchComics(offset: currentPage * pageSize) { [weak self] result in
            DispatchQueue.main.async {
                self?.isFetching = false
                switch result {
                case .success(let comics):
                    self?.comics.append(contentsOf: comics)
                    self?.noResultsFound = self?.comics.isEmpty ?? false
                    self?.currentPage += 1
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func searchComicsByTitle(title: String) {
        guard !isFetching else { return }
        isFetching = true
        isLoading = true // Start loading
        
        apiClient.searchComicsByTitle(title: title, offset: currentPage * pageSize) { [weak self] result in
            DispatchQueue.main.async {
                self?.isFetching = false
                self?.isLoading = false // Stop loading
                switch result {
                case .success(let comics):
                    self?.comics.append(contentsOf: comics)
                    self?.noResultsFound = self?.comics.isEmpty ?? false
                    self?.currentPage += 1
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
