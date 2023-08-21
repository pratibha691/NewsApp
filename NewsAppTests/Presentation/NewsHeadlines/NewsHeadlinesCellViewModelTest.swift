//
//  NewsHeadlinesCellViewModelTest.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 18/08/23.
//
import XCTest
import PromiseKit
@testable import NewsApp

class NewsHeadlinesCellViewModelTests: XCTestCase {
    
    // Test initializing the view model with a news article
    func testInitWithArticle() {
        // Given
        guard let articles = MockResponseManager.loadMockResponse(ofType: NewsApiResponse.self, from: "News")?.articles else {
            return
        }
        let article = articles[0]
        // When
        let cellViewModel = NewsHeadlinesCellViewModel(article: article)
        
        // Then
        XCTAssertEqual(cellViewModel.title, "Tiranga Trumps Terror As J&K Independence Day Celebrations See Huge Rush - NDTV")
        XCTAssertEqual(cellViewModel.source, "Ndtv News")
        XCTAssertEqual(cellViewModel.imageUrl, URL(string: "https://cdn.ndtv.com/common/images/ogndtv.png"))
        XCTAssertEqual(cellViewModel.publishedDate, "15 Aug 2023")
    }
    
    // Test initializing the view model with nil values
    func testInitWithNilValues() {
        // Given
        guard let articles = MockResponseManager.loadMockResponse(ofType: NewsApiResponse.self, from: "News")?.articles else {
            return
        }
        let article = articles[1]
        
        // When
        let viewModel = NewsHeadlinesCellViewModel(article: article)
        
        // Then
        XCTAssertNil(viewModel.imageUrl)
    }
}
