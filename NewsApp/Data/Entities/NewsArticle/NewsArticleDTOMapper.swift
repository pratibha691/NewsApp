//
//  NewsArticleDTOMapper.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 25/08/23.
//

import Foundation
struct NewsArticleDTOMapper {
    
    static func getArticles(dataApiResponse: NewsApiResponseDTO?) -> [NewsArticle] {
        guard let dataArticles = dataApiResponse?.articles else {
            return []
        }
        
        return dataArticles.map { dataArticle in
            let domainSourceName = dataArticle.source.name
            let domainTitle = dataArticle.title
            let domainUrl = dataArticle.url
            let domainUrlToImage = dataArticle.urlToImage
            let domainPublishedAt = dataArticle.publishedAt
            let domainContent = dataArticle.content
            
            return NewsArticle(sourceName: domainSourceName,
                               title: domainTitle,
                               url: domainUrl,
                               urlToImage: domainUrlToImage,
                               publishedAt: domainPublishedAt,
                               content: domainContent)
        }
    }
}
