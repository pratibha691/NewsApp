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
        let article = NewsArticle(source: NewsSource(id: "bbc", name: "BBC News"), author: "Author1", title: "Sample Title1", description: "Description 1", url: "https://www.example.com", urlToImage: "https://www.example.com/image.jpg", publishedAt: "2023-08-10T10:31:35Z", content: "Sample Content")
        
        // When
        let viewModel = NewsHeadlinesCellViewModel(article: article)
        
        // Then
        XCTAssertEqual(viewModel.title, "Sample Title1")
        XCTAssertEqual(viewModel.source, "Bbc News")
        XCTAssertEqual(viewModel.imageUrl, URL(string: "https://www.example.com/image.jpg"))
        XCTAssertEqual(viewModel.publishedDate, "10 Aug 2023")
    }
    
    // Test initializing the view model with nil values
    func testInitWithNilValues() {
        // Given
        let article = NewsArticle(source: NewsSource(id: "bbc", name: "BBC News"), author: "Author1", title: "", description: "Description 1", url: nil, urlToImage: nil, publishedAt: nil, content: "Sample Content")
        
        // When
        let viewModel = NewsHeadlinesCellViewModel(article: article)
        
        // Then
        XCTAssertEqual(viewModel.title, "")
        XCTAssertEqual(viewModel.source, "Bbc News")
        XCTAssertNil(viewModel.imageUrl)
        XCTAssertEqual(viewModel.publishedDate, "")
    }
}
