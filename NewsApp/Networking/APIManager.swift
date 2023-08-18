//
//  APIManager.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation
import PromiseKit
class APIManager: ServiceProtocol {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    func request<T: Decodable>(_ service: RequestProtocol, responseType: T.Type) -> Promise<T> {
        return Promise { seal in
            
            guard let url = buildURL(from: service) else {
                seal.reject(APIError.invalidURL)
                return
            }
            let task = session.dataTaskWithURL(url) { [weak self] (data, _, error) in
                if let error = error {
                    seal.reject(error)
                    return
                }
                self?.handleResponseData(data, responseType: responseType, seal: seal)
            }
            task.resume()
        }
    }

    private func buildURL(from service: RequestProtocol) -> URL? {
        var urlComponents = URLComponents(string: service.requestURL)
        var query = "apiKey=\(service.apiKey)"
        if !service.requestQueryParam.isEmpty {
            query = "\(query)&\(service.requestQueryParam)"
        }
        urlComponents?.query = query
        return urlComponents?.url
    }

    private func handleResponseData<T: Decodable>(_ data: Data?, responseType: T.Type, seal: Resolver<T>) {
        guard let data = data else {
            seal.reject(APIError.noData)
            return
        }
        do {
            let decoder = JSONDecoder()
            let responseObject = try decoder.decode(T.self, from: data)
            seal.fulfill(responseObject)
        } catch {
            seal.reject(error)
        }
    }
}
