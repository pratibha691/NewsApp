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
    var articles: [NewsArticle]!
    
    override func setUp() {
        super.setUp()
        viewModel = NewsHeadlinesViewModel()
        fetchNewsArticles()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test fetching news articles
    func fetchNewsArticles() {
        // Inject the mocked API manager
        viewModel.apiManager = MockNewsHeadlinesAPIManager()
        
        let expectation = self.expectation(description: "Fetch News Articles")
        viewModel.fetchNewsArticles { error in
            XCTAssertNil(error, "Error fetching news articles")
            XCTAssertEqual(self.viewModel.numberOfRows(), 3)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Test number of rows
    func testNumberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows(), 3)
    }
    
    func testArticleAtIndex() {
        XCTAssertNotNil(viewModel.article(at: 0))
        XCTAssertEqual(viewModel.article(at: 0)?.title, "Tiranga Trumps Terror As J&K Independence Day Celebrations See Huge Rush - NDTV")
    }
}
// Mocked NewsHeadlinesAPIManager
class MockNewsHeadlinesAPIManager: NewsHeadlinesAPIManager {
    override func getNewsArticles() -> Promise<NewsApiResponse> {
        return MockAPIManager.loadMockResponse(from: "News")
            .map { mockResponse in
                return mockResponse
            }
    }
}
