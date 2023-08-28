//
//  NewsDetailsViewModel.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 11/08/23.
//

import Foundation
class NewsDetailsViewModel {
    
    private let newsArticle: NewsArticle
    
    init(newsArticle: NewsArticle) {
        self.newsArticle = newsArticle
    }
    var title: String {
        return newsArticle.title.orEmpty()
    }
    var source: String {
        return newsArticle.sourceName ?? ""
    }
    var content: String {
        return newsArticle.content.orEmpty()
    }
    var publishedAt: String {
        return newsArticle.publishedAt.orEmpty().formattedDate()
    }
    var fullStoryUrl: URL? {
        return URL(string: newsArticle.url.orEmpty())
    }
    var imageUrl: URL? {
        return URL(string: newsArticle.urlToImage.orEmpty())
    }
    
}
