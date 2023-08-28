//
//  NewsHeadlinesViewModelTest.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 13/08/23.
//

import XCTest
import PromiseKit
@testable import NewsApp

final class NewsHeadlinesViewModelTest: XCTestCase {
    
    var viewModel: NewsHeadlinesViewModel!
    
    class MockFetchNewsHeadlinesUseCase: FetchNewsHeadlinesUseCaseProtocol {
        var newsArticles: [NewsArticle]?
        var error: Error?
        
        func execute() -> Promise<[NewsArticle]> {
            if let error = error {
                return Promise(error: error)
            }
            let response = newsArticles ?? []
            return Promise.value(response)
        }
    }
    
    override func setUp() {
        viewModel = NewsHeadlinesViewModel(newsHeadlinesUseCase: MockFetchNewsHeadlinesUseCase())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    // Test fetching news articles successfully
    func testFetchNewsArticlesSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch news articles successfully")
        
        let mockResponse = MockResponseManager.loadMockResponse(ofType: NewsApiResponseDTO.self, from: "News")
        
        if let useCase = viewModel.newsHeadlinesUseCase as? MockFetchNewsHeadlinesUseCase {
            useCase.newsArticles = NewsArticleDTOMapper.getArticles(dataApiResponse: mockResponse)
        }
        viewModel.fetchNewsArticles()
        viewModel.newsArticles.bind { [weak self] _ in
            XCTAssertEqual(self?.viewModel.numberOfRows(), 3)
            XCTAssertNotNil(self?.viewModel.article(at: 0))
            
            let cellViewModel = self?.viewModel.getCellViewModel(at: 0)
            XCTAssertNotNil(cellViewModel)
            
            let detailViewModel = self?.viewModel.getNewDetailViewModel(at: 0)
            XCTAssertNotNil(detailViewModel)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test fetching news articles with an error
    func testFetchNewsArticlesError() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch news articles with error")
        
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        if let useCase = viewModel.newsHeadlinesUseCase as? MockFetchNewsHeadlinesUseCase {
            useCase.error = mockError
        }
        viewModel.fetchNewsArticles()
        viewModel.errorMessage.bind { [weak self] error in
            XCTAssertNotNil(error)
            XCTAssertEqual(self?.viewModel.numberOfRows(), 0)
            XCTAssertNil(self?.viewModel.article(at: 0))
            let cellViewModel = self?.viewModel.getCellViewModel(at: 0)
            XCTAssertNil(cellViewModel)
            
            let detailViewModel = self?.viewModel.getNewDetailViewModel(at: 0)
            XCTAssertNil(detailViewModel)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

    }
    
}
