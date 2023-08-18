//
//  SessionProtocol.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 17/08/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}
extension URLSessionDataTask: URLSessionDataTaskProtocol { }

typealias DataCompletion = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(_ url: URL, completion: @escaping DataCompletion)
    -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTaskWithURL(_ url: URL, completion completionHandler: @escaping DataCompletion)
    -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}
