//
//  NewsDetailsViewControllerSnapshotTests.swift
//  NewsAppUITests
//
//  Created by Pratibha Gupta on 14/08/23.
//

import XCTest
import FBSnapshotTestCase
@testable import NewsApp

final class NewsDetailsViewControllerSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        // Set the recordMode to true initially to generate reference snapshots
       // self.recordMode = true
       self.bundleResourcePath = FileManager.default.temporaryDirectory.appendingPathComponent("ReferenceImages").path
    }
    
    func testNewsDetailsViewController() {
        let newsDetailsVC: NewsDetailsViewController = NewsDetailsViewController.instantiateFromStoryboard()
        newsDetailsVC.viewModel = NewsDetailsViewModel(newsArticle: NewsArticle(sourceName: "BBC News", title: "Sample Title", url: "https://www.example.com", urlToImage: "https://www.example.com/image.jpg", publishedAt: "2023-08-10T10:31:35Z", content: "Sample Content"))

        FBSnapshotVerifyView(newsDetailsVC.view)
    }
}
