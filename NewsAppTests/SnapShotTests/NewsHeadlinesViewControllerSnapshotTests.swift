//
//  NewsHeadlinesViewControllerSnapshotTests.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 14/08/23.
//

import XCTest
import FBSnapshotTestCase
@testable import NewsApp

final class NewsHeadlinesViewControllerSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        // Set the recordMode to true initially to generate reference snapshots
        // self.recordMode = true
        bundleResourcePath = FileManager.default.temporaryDirectory.appendingPathComponent("ReferenceImages").path
    }
    
    func testNewsDetailsViewController() {
        let newsDetailsVC: NewsHeadlinesViewController = NewsHeadlinesViewController.instantiateFromStoryboard() 
        newsDetailsVC.viewModel = NewsHeadlinesViewModel()
        newsDetailsVC.viewModel.newsArticles = [NewsArticle(source: NewsSource(id: "bbc", name: "BBC News"), author: "Author1", title: "Sample Title", description: "Description 1", url: "https://www.example.com", urlToImage: "https://www.example.com/image.jpg", publishedAt: "2023-08-10T10:31:35Z", content: "Sample Content")]

        FBSnapshotVerifyView(newsDetailsVC.view)
    }
}
