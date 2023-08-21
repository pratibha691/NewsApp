//
//  MockUrlSession.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 18/08/23.
//

import PromiseKit
@testable import NewsApp// Mock URLSessionProtocol for testing

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTaskWithURL(_ url: URL, completion completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let data = self.data
        let response = self.response
        let error = self.error
        
        return MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }
}

// Mock URLSessionDataTaskProtocol for testing
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    func resume() {
        closure()
    }
}
