//
//  NetworkManager.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 13.08.2022.
//

import Foundation

enum Link: String {
    case images = "/five_star_shop/"
    case allProducts = "/api/products"
    case authentication = "/api/users"
    case registration = "/api/users/add"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case notFound
    case dublicateUser
    case decodingError
    case notResponse
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let hostname = "https://ledkov.org" // "http://localhost:8080"
    
    private init() {}
    
    func getLink(_ link: Link) -> String {
        hostname + link.rawValue
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String?, completion: @escaping(Result<T,NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func postRequest(with data: [String: Any], to url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let postData = try? JSONSerialization.data(withJSONObject: data)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 404:
                    completion(.failure(.notFound))
                    return
                case 302:
                    completion(.failure(.dublicateUser))
                    return
                default:
                    completion(.success(data))
                }
            } else {
                completion(.failure(.notResponse))
            }
        }.resume()
    }
}
