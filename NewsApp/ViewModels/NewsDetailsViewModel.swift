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
        return newsArticle.title.valueOrEmpty
    }
    var source: String {
        return newsArticle.source.name
    }
    var content: String {
        return newsArticle.content.valueOrEmpty
    }
    var publishedAt: String {
        return newsArticle.publishedAt.valueOrEmpty.formattedDate()
    }
    
    var fullStoryUrl: URL? {
        return URL(string: newsArticle.url ?? "")
    }
    var imageUrl: URL? {
        return URL(string: newsArticle.urlToImage ?? "")
    }
    
}
