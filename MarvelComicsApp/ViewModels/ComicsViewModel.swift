import Foundation
import Combine

class ComicsViewModel: ObservableObject {
    @Published var comics: [Comic] = []  // Published array of comics to update views
    @Published var errorMessage: String?  // Published error message for UI feedback
    @Published var isLoading: Bool = false  // Published loading state for UI feedback
    private var apiClient = MarvelAPIClient()  // Instance of API client for fetching data
    private var cancellables = Set<AnyCancellable>()  // Set of Combine cancellables for managing async tasks
    @Published var noResultsFound: Bool = false
    
    
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
    // Fetches comics from API and updates view model
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
    // Searches comics by title from API and updates view model
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
