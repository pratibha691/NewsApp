//
//  NewsDetailsViewModel.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 11/08/23.
//

import Foundation

protocol NewsDetailsViewModelProtocol {
    var title: String { get }
    var source: String { get }
    var content: String { get }
    var publishedAt: String { get }
    var fullStoryUrl: URL? { get }
    var imageUrl: URL? { get }
}

final class NewsDetailsViewModel: NewsDetailsViewModelProtocol {
    
    private let newsArticle: NewsArticle
    
    init(newsArticle: NewsArticle) {
        self.newsArticle = newsArticle
    }
    
    var title: String {
        newsArticle.title.orEmpty()
    }
    
    var source: String {
        newsArticle.sourceName ?? ""
    }
    
    var content: String {
        newsArticle.content.orEmpty()
    }
    
    var publishedAt: String {
        newsArticle.publishedAt.orEmpty().formattedDate()
    }
    
    var fullStoryUrl: URL? {
         URL(string: newsArticle.url.orEmpty())
    }
    
    var imageUrl: URL? {
        URL(string: newsArticle.urlToImage.orEmpty())
    }
}
