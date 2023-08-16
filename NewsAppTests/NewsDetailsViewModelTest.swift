//
//  NewsDetailsViewModelTest.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 14/08/23.
//

import XCTest
@testable import NewsApp

class NewsDetailsViewModelTests: XCTestCase {
    
    var viewModel: NewsDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        setupMockData()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    func setupMockData() {
        let expectation = self.expectation(description: "Fetch News Articles")
        MockNewsHeadlinesAPIManager().getNewsArticles()
            .done { [weak self] articles in
                if let newsArticles = articles.articles {
                    self?.viewModel = NewsDetailsViewModel(newsArticle: newsArticles[0])
                }
                expectation.fulfill()
            }
            .catch { error in
                print(error.localizedDescription)
            }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testTitle() {
        XCTAssertEqual(viewModel.title, "Tiranga Trumps Terror As J&K Independence Day Celebrations See Huge Rush - NDTV")
    }
    
    func testSource() {
        XCTAssertEqual(viewModel.source, "NDTV News")
    }
    
    func testContent() {
        XCTAssertEqual(viewModel.content, "Prime Minister Narendra Modi on Tuesday highlighted the importance of regional languages during his Independence Day speech from the ramparts of the iconic Red Fort. Referring to the recent move by t… [+1993 chars]")
    }
    
    func testPublishedAt() {
        XCTAssertEqual(viewModel.publishedAt, "15 Aug 2023")
    }
    
    func testFullStoryUrl() {
        XCTAssertEqual(viewModel.fullStoryUrl?.absoluteString, "https://www.ndtv.com/news")
    }
    func testImageUrl() {
        XCTAssertEqual(viewModel.imageUrl?.absoluteString, "https://cdn.ndtv.com/common/images/ogndtv.png")
    }
}
