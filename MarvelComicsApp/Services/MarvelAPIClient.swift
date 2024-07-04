import Foundation
import CryptoKit

class MarvelAPIClient {
    private let baseURL = "https://gateway.marvel.com:443/v1/public/comics"

    func fetchComics(offset: Int, completion: @escaping (Result<[Comic], Error>) -> Void) {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(Constants.privateKey)\(Constants.publicKey)")

        let urlString = "\(baseURL)?apikey=\(Constants.publicKey)&ts=\(timestamp)&hash=\(hash)&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.data.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func searchComicsByTitle(title: String, offset: Int, completion: @escaping (Result<[Comic], Error>) -> Void) {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(Constants.privateKey)\(Constants.publicKey)")

        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?apikey=\(Constants.publicKey)&ts=\(timestamp)&hash=\(hash)&titleStartsWith=\(encodedTitle)&offset=\(offset)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.data.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }

    private struct APIResponse: Codable {
        let data: DataClass

        struct DataClass: Codable {
            let results: [Comic]
        }
    }
}
