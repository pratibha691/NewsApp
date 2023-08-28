//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation

struct NewsApiResponseDTO: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [NewsArticleDTO]?
}

struct NewsArticleDTO: Decodable {
    let source: NewsSourceDTO
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct NewsSourceDTO: Decodable {
    let id: String?
    let name: String
}
