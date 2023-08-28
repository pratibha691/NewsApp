//
//  NewsHeadlinesCellViewModel.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 18/08/23.
//

import Foundation

struct NewsHeadlinesCellViewModel {
    let title: String
    let source: String
    let imageUrl: URL?
    let publishedDate: String
}

extension NewsHeadlinesCellViewModel {
    init(article: NewsArticle) {
        title = article.title.orEmpty()
        source = article.sourceName ?? ""
        imageUrl = URL(string: article.urlToImage.orEmpty())
        let date = article.publishedAt?.formattedDate()
        publishedDate = date.orEmpty()
    }
}
