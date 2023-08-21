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
    
    class MockFetchNewsHeadlinesUseCase: FetchNewsHeadlinesUseCase {
        var newsArticles: [NewsArticle]?
        var error: Error?
        
        override func execute() -> Promise<NewsApiResponse> {
            if let error = error {
                return Promise(error: error)
            }
            let response = NewsApiResponse(status: "", totalResults: 2, articles: newsArticles)
            return Promise.value(response)
        }
    }
    
    override func setUp() {
        viewModel = NewsHeadlinesViewModel(newsHeadlinesUseCase: MockFetchNewsHeadlinesUseCase())
    }
    // Test fetching news articles successfully
    func testFetchNewsArticlesSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch news articles successfully")
        
        let mockArticles = MockResponseManager.loadMockResponse(ofType: NewsApiResponse.self, from: "News")?.articles
        
        if let useCase = viewModel.newsHeadlinesUseCase as? MockFetchNewsHeadlinesUseCase {
            useCase.newsArticles = mockArticles
        }        
        // When
        viewModel.fetchNewsArticles { [weak self] error in
            // Then
            XCTAssertNil(error)
            XCTAssertEqual(self?.viewModel.numberOfRows(), mockArticles?.count)
            XCTAssertNotNil(self?.viewModel.article(at: 0))
            
            let cellViewModel = self?.viewModel.getCellViewModel(at: 0)
            XCTAssertNotNil(cellViewModel)
            XCTAssertEqual(cellViewModel?.title, "Tiranga Trumps Terror As J&K Independence Day Celebrations See Huge Rush - NDTV")
            XCTAssertEqual(cellViewModel?.source, "Ndtv News")
            XCTAssertEqual(cellViewModel?.imageUrl, URL(string: "https://cdn.ndtv.com/common/images/ogndtv.png"))
            XCTAssertEqual(cellViewModel?.publishedDate, "15 Aug 2023")
            
            let detailViewModel = self?.viewModel.getNewDetailViewModel(at: 0)
            XCTAssertNotNil(detailViewModel)
            XCTAssertEqual(detailViewModel?.title, "Tiranga Trumps Terror As J&K Independence Day Celebrations See Huge Rush - NDTV")
            XCTAssertEqual(detailViewModel?.source, "NDTV News")
            XCTAssertEqual(detailViewModel?.imageUrl, URL(string: "https://cdn.ndtv.com/common/images/ogndtv.png"))
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
        // When
        viewModel.fetchNewsArticles { [weak self] error in
            // Then
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
