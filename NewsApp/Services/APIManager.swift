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
    
    /// Makes a network request to the specified API endpoint and returns a Promise with the decoded response.
    /// - Parameters:
    ///   - endpoint: The API endpoint to request data from.
    ///   - method: The HTTP method for the request. Default is `.get`.
    ///   - parameters: Optional parameters to include in the request body.
    ///   - responseType: The type to decode the JSON response into.
    /// - Returns: A Promise that resolves with the decoded response or rejects with an error.
    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, responseType: T.Type) -> Promise<T> {
        return Promise { seal in
            var urlString = "\(APIEndPoints.baseUrl)\(endpoint)"
            if let apiKey = apiKey {
                urlString = "\(urlString)&apiKey=\(apiKey)"
            }
            
            guard let url = URL(string: urlString) else {
                seal.reject(APIError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            // Check if parameters are provided and add them to the request body
            if let params = parameters {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
                    request.httpBody = jsonData
                } catch {
                    // Handle serialization error
                    seal.reject(error)
                    return
                }
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    // Handle network error
                    seal.reject(error)
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let responseObject = try decoder.decode(responseType, from: data)
                        seal.fulfill(responseObject)
                    } catch {
                        // Handle decoding error
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
