//
//  NewsDetailsViewModelTest.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 14/08/23.
//

import XCTest
@testable import NewsApp

class NewsDetailsViewModelTests: XCTestCase {
    
    // Test initializing the view model
    func testInit() {
        // Given
        guard let articles = MockResponseManager.loadMockResponse(ofType: NewsApiResponse.self, from: "News")?.articles else {
            return
        }
        let article = articles[0]
        let viewModel = NewsDetailsViewModel(newsArticle: article)

        // Then
        XCTAssertEqual(viewModel.title, "Tiranga Trumps Terror As J&K Independence Day Celebrations See Huge Rush - NDTV")
        XCTAssertEqual(viewModel.source, "NDTV News")
        XCTAssertEqual(viewModel.content, "Prime Minister Narendra Modi on Tuesday highlighted the importance of regional languages during his Independence Day speech from the ramparts of the iconic Red Fort. Referring to the recent move by t… [+1993 chars]")
        XCTAssertEqual(viewModel.publishedAt, "15 Aug 2023")
        XCTAssertEqual(viewModel.fullStoryUrl, URL(string: "https://www.ndtv.com/news"))
        XCTAssertEqual(viewModel.imageUrl, URL(string: "https://cdn.ndtv.com/common/images/ogndtv.png"))
    

    }
    
    // Test URL conversion when URLs are nil
    func testNilURLs() {
        // Given
        guard let articles = MockResponseManager.loadMockResponse(ofType: NewsApiResponse.self, from: "News")?.articles else {
            return
        }
        let article = articles[1]
        let viewModel = NewsDetailsViewModel(newsArticle: article)
        
        // Then
        XCTAssertNil(viewModel.fullStoryUrl)
        XCTAssertNil(viewModel.imageUrl)
    }
}
