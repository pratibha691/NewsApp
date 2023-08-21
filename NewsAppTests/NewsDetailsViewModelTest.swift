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
        let newsArticle = NewsArticle(source: NewsSource(id: "bbc", name: "BBC News"), author: "Author1", title: "Sample Title1", description: "Description 1", url: "https://www.example.com", urlToImage: "https://www.example.com/image.jpg", publishedAt: "2023-08-10T10:31:35Z", content: "Sample Content")
        
        // When
        let viewModel = NewsDetailsViewModel(newsArticle: newsArticle)
        
        // Then
        XCTAssertEqual(viewModel.title, "Sample Title1")
        XCTAssertEqual(viewModel.source, "BBC News")
        XCTAssertEqual(viewModel.content, "Sample Content")
        XCTAssertEqual(viewModel.publishedAt, "10 Aug 2023")
        XCTAssertEqual(viewModel.fullStoryUrl, URL(string: "https://www.example.com"))
        XCTAssertEqual(viewModel.imageUrl, URL(string: "https://www.example.com/image.jpg"))
    }
    
    // Test URL conversion when URLs are nil
    func testNilURLs() {
        // Given
        let newsArticle = NewsArticle(source: NewsSource(id: "bbc", name: "BBC News"), author: "Author1", title: "Sample Title1", description: "Description 1", url: nil, urlToImage: nil, publishedAt: "2023-08-10T10:31:35Z", content: "Sample Content")
        
        // When
        let viewModel = NewsDetailsViewModel(newsArticle: newsArticle)
        
        // Then
        XCTAssertNil(viewModel.fullStoryUrl)
        XCTAssertNil(viewModel.imageUrl)
    }
}
