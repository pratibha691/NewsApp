//
//  FetchNewsHeadlinesUseCaseTest.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 21/08/23.
//
import XCTest
import PromiseKit
@testable import NewsApp

class FetchNewsHeadlinesUseCaseTests: XCTestCase {
    
    // Mock NewsHeadlinesRepository for testing
    class MockNewsHeadlinesRepository: NewsHeadlinesRepository {
        var newsApiResponse: [NewsArticle]?
        var error: Error?
        
        func getNewsHeadlines() -> Promise<[NewsArticle]> {
            if let error = error {
                return Promise(error: error)
            }
            if let newsApiResponse = newsApiResponse {
                return Promise.value(newsApiResponse)
            }
            return Promise(error: APIError.noData) // Default to no data
        }
    }
    var repository: MockNewsHeadlinesRepository!

    override func setUp() {
        super.setUp()
        repository = MockNewsHeadlinesRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    // Test fetching news headlines successfully
    func testFetchNewsHeadlinesSuccess() {
        // Given
        guard let mockApiResponse = MockResponseManager.loadMockResponse(ofType: NewsApiResponseDTO.self, from: "News") else {
            return
        }
        repository.newsApiResponse = NewsArticleDTOMapper.getArticles(dataApiResponse: mockApiResponse)
        
        let useCase = FetchNewsHeadlinesUseCase(newsRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch news headlines successfully")
        let promise: Promise<[NewsArticle]> = useCase.execute()
        
        promise.done { response in
            // Then
            XCTAssertEqual(response.count, 3)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test fetching news headlines with an error
    func testFetchNewsHeadlinesError() {
        // Given
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        repository.error = mockError
        
        let useCase = FetchNewsHeadlinesUseCase(newsRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch news headlines with error")
        let promise: Promise<[NewsArticle]> = useCase.execute()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertEqual(error as NSError, mockError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test fetching news headlines with no data
    func testFetchNewsHeadlinesNoData() {
        // Given

        let useCase = FetchNewsHeadlinesUseCase(newsRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch news headlines with no data")
        let promise: Promise<[NewsArticle]> = useCase.execute()
        
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
}
