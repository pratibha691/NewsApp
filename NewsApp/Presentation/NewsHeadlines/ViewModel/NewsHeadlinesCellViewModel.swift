//
//  NewsHeadlinesCellViewModel.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 18/08/23.
//

import Foundation

protocol NewsHeadlinesCellViewModelProtocol {
    var title: String { get }
    var source: String { get }
    var imageUrl: URL? { get }
    var publishedDate: String { get }
}

struct NewsHeadlinesCellViewModel: NewsHeadlinesCellViewModelProtocol {
    let title: String
    let source: String
    let imageUrl: URL?
    let publishedDate: String

    init(article: NewsArticle) {
        title = article.title.orEmpty()
        source = article.sourceName ?? ""
        imageUrl = URL(string: article.urlToImage.orEmpty())
        let date = article.publishedAt?.formattedDate()
        publishedDate = date.orEmpty()
    }
}
