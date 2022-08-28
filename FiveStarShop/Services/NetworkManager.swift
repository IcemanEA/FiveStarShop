//
//  NetworkManager.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 13.08.2022.
//

import Foundation

enum Link: String {
    case backslash = "/"
    case images = "/five_star_shop/"
    case allProducts = "/api/products"
    case authentication = "/api/users"
    case registration = "/api/users/add"
    case activeUser = "/api/users/"
    case activeUserOrders = "/orders/"
    case addOrder = "/api/orders/"
}

enum PostRequestType {
    case checkUserPassword
    case addOrder
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let hostname = "http://localhost:8080"
    //private let hostname = "https://ledkov.org"

    private init() {}
    
    func getLink(_ link: Link) -> String {
        hostname + link.rawValue
    }
    func getUserLink(for userID: String, _ link: Link) -> String {
        hostname + Link.activeUser.rawValue + userID + link.rawValue
    }
    
    // MARK: - GET methods
    func fetch<T: Decodable>(_ type: T.Type, from url: String?, completion: @escaping(Result<T,NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonDecodeData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonDecodeData))
                }
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {        
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
    
    // MARK: - POST methods
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
                case 208:
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
    
    func setupRequestBody(_ requestType: PostRequestType, userID: UUID? = nil, data: Any) -> [String: Any] {
        var request: [String: Any] = [:]
        
        switch requestType {
        case .checkUserPassword:
            guard let credits = data as? [String] else { return [:] }
            
            if credits.count >= 2 {
                request = [
                    "username": credits[0],
                    "password": credits[1]
                ]
            }
            if credits.count == 3 {
                request["name"] = credits[2]
            }
        case .addOrder:
            guard let credits = data as? [Purchase] else { return [:] }
            
            var purchases: [[String: Any]] = []
            for credit in credits {
                let purchase: [String: Any] = [
                    "productID": credit.product.id?.uuidString ?? "",
                    "count": credit.count
                ]
                purchases.append(purchase)
            }
            
            request = [
                "userID": userID?.uuidString ?? "",
                "purchases": purchases
            ]
        }
        return request
    }
}
