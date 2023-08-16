//
//  APIManager.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation
import PromiseKit
class APIManager {
    
    var apiKey: String? {
        return  Bundle.main.infoDictionary?["ApiKey"] as? String
    }
    
     func request<T: Decodable>(_ endpoint: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, responseType: T.Type) -> Promise<T> {
        return Promise { seal in
            var urlString = "\(APIEndPoints.baseUrl)\(endpoint)"
            if let apiKey = apiKey {
                // Use the apiKey value in your code
                urlString = "\(urlString)&apiKey=\(apiKey)"
            }
            
            guard let url = URL(string: urlString) else {
                seal.reject(APIError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            do {
                if let params = parameters {
                    let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
                    request.httpBody = jsonData
                }
            } catch {
                print("Error serializing JSON: \(error)")
            }

            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    seal.reject(error)
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let responseObject = try decoder.decode(responseType, from: data)
                        seal.fulfill(responseObject)
                    } catch {
                        seal.reject(error)
                    }
                }
            }
            task.resume()
        }
    }
}

enum APIError: Error {
    case invalidURL
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add more HTTP methods as needed
}
