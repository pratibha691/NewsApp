//
//  NewsDetailsViewModel.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 11/08/23.
//

import Foundation
final class NewsDetailsViewModel {
    
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
