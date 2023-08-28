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
    // Test initializing the view model with a news article
    func testInitWithArticle() {
        
        let cellViewModel = NewsHeadlinesCellViewModel(article: articles[0])
        XCTAssertEqual(cellViewModel.title, "Tiranga Trumps Terror As J&K Independence Day Celebrations See Huge Rush - NDTV")
        XCTAssertEqual(cellViewModel.source, "NDTV News")
        XCTAssertEqual(cellViewModel.imageUrl, URL(string: "https://cdn.ndtv.com/common/images/ogndtv.png"))
        XCTAssertEqual(cellViewModel.publishedDate, "15 Aug 2023")
    }
    // Test initializing the view model with nil values
    func testInitWithNilValues() {
        
        let viewModel = NewsHeadlinesCellViewModel(article: articles[1])
        XCTAssertNil(viewModel.imageUrl)
    }
}
