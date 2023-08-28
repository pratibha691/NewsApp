//
//  NewsDetailsViewModelTest.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 14/08/23.
//

import XCTest
@testable import NewsApp

class NewsDetailsViewModelTests: XCTestCase {
    
    var articles: [NewsArticle]!
    
    override func setUp() {
        guard let response = MockResponseManager.loadMockResponse(ofType: NewsApiResponseDTO.self, from: "News") else {
            return
        }
        articles = NewsArticleDTOMapper.getArticles(dataApiResponse: response)
       
    }
    override func tearDown() {
        articles = nil
        super.tearDown()
    }
    func testInit() {
        
        let article = self.articles[0]
        let viewModel = NewsDetailsViewModel(newsArticle: article)
        
        XCTAssertEqual(viewModel.title, "Tiranga Trumps Terror As J&K Independence Day Celebrations See Huge Rush - NDTV")
        XCTAssertEqual(viewModel.source, "NDTV News")
        XCTAssertEqual(viewModel.content, "Prime Minister Narendra Modi on Tuesday highlighted the importance of regional languages during his Independence Day speech from the ramparts of the iconic Red Fort. Referring to the recent move by t… [+1993 chars]")
        XCTAssertEqual(viewModel.publishedAt, "15 Aug 2023")
        XCTAssertEqual(viewModel.fullStoryUrl, URL(string: "https://www.ndtv.com/news"))
        XCTAssertEqual(viewModel.imageUrl, URL(string: "https://cdn.ndtv.com/common/images/ogndtv.png"))
    }
    
    // Test URL conversion when URLs are nil
    func testNilURLs() {
        let article = self.articles[1]
        let viewModel = NewsDetailsViewModel(newsArticle: article)
        
        XCTAssertNil(viewModel.fullStoryUrl)
        XCTAssertNil(viewModel.imageUrl)
    }
}
