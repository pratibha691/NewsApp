//
//  APIManagerTest.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 18/08/23.
//

import XCTest
import PromiseKit
@testable import NewsApp

class APIManagerTests: XCTestCase {
    
    // Test successful API request
    func testAPIRequestSuccess() {
        // Given
        
        let session = MockURLSession()
        session.data = """
            {
                "title": "Test ",
                "description": "This is a description"
            }
            """.data(using: .utf8)
        
        let apiManager = APIManager(session: session)
        
        let request = MockRequest()
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<MockResponse> = apiManager.request(request, responseType: MockResponse.self)
        
        promise.done { response in
            // Then
           XCTAssertNotNil(response)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test API request failure
    func testAPIRequestFailure() {
        // Given
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        
        let session = MockURLSession()
        session.error = mockError
        
        let apiManager = APIManager(session: session)
        let request = MockRequest()
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<MockResponse> = apiManager.request(request, responseType: MockResponse.self)
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertEqual(error as NSError, mockError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
     // Test API request with no data
     func testAPIRequestNoData() {
         
         let session = MockURLSession()
         session.data = nil
         
         let apiManager = APIManager(session: session)
         let request = MockRequest()
         
         // When
         let expectation = XCTestExpectation(description: "API request with no data")
         let promise: Promise<MockResponse> = apiManager.request(request, responseType: MockResponse.self)
         
         promise.done { _ in
             XCTFail("Promise should not fulfill")
         }.catch { error in
             // Then
             XCTAssertTrue(error is APIError)
             XCTAssertEqual(error as? APIError, APIError.noData)
             expectation.fulfill()
         }
         
         wait(for: [expectation], timeout: 1.0)
     }
    // Test API request with decoding error
    func testAPIRequestDecodingError() {
        // Given
        let mockData = """
            {
                "invalidKey": "Test Article"
            }
            """.data(using: .utf8)
        
        let session = MockURLSession()
        session.data = mockData
        
        let apiManager = APIManager(session: session)
        let request = MockRequest()
        
        // When
        let expectation = XCTestExpectation(description: "API request with decoding error")
        let promise: Promise<MockResponse> = apiManager.request(request, responseType: MockResponse.self)
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, APIError.decodingError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// Mock implementations for testing
extension APIManagerTests {
    struct MockRequest: RequestProtocol {
        var requestQueryParam: String = ""
        var apiKey: String = ""
        var httpMethod: NewsApp.HTTPMethod = .get
        var requestParams: [String: Any]?
        var additionalHeaders: [String: String]?
        let requestURL: String = ""
    }

    struct MockResponse: Decodable {
        var title: String = ""
        var description: String = ""
    }
}
