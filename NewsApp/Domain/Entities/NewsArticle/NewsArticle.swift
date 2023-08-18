//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation

struct NewsApiResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [NewsArticle]?
}

struct NewsArticle: Decodable {
    let source: NewsSource
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct NewsSource: Decodable {
    let id: String?
    let name: String
}
