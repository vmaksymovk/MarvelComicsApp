import Foundation
import CryptoKit

class MarvelAPIClient {
    private let baseURL = "https://gateway.marvel.com:443/v1/public/comics"

    // Fetches comics with pagination using offset
    func fetchComics(offset: Int, completion: @escaping (Result<[Comic], Error>) -> Void) {
        let queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        fetchComics(with: queryItems, completion: completion)
    }

    // Searches for comics by title with pagination using offset
    func searchComicsByTitle(title: String, offset: Int, completion: @escaping (Result<[Comic], Error>) -> Void) {
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let queryItems = [
            URLQueryItem(name: "titleStartsWith", value: encodedTitle),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        fetchComics(with: queryItems, completion: completion)
    }

    // Common method to fetch comics with additional query items
    private func fetchComics(with additionalQueryItems: [URLQueryItem], completion: @escaping (Result<[Comic], Error>) -> Void) {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(Constants.privateKey)\(Constants.publicKey)")

        // Build URL components with base URL and query items
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "apikey", value: Constants.publicKey),
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash)
        ] + additionalQueryItems

        // Ensure URL is valid
        guard let url = components.url else {
            completion(.failure(MarvelAPIError.invalidURL))
            return
        }

        // Perform data task
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            // Ensure data is received
            guard let data = data else {
                completion(.failure(MarvelAPIError.noData))
                return
            }

            // Decode JSON response
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.data.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Computes MD5 hash for given string
    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }

    // Data model for API response
    private struct APIResponse: Codable {
        let data: DataClass

        struct DataClass: Codable {
            let results: [Comic]
        }
    }

    // Custom error types for Marvel API client
    private enum MarvelAPIError: Error, LocalizedError {
        case invalidURL
        case noData

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .noData:
                return "No data received"
            }
        }
    }
}
