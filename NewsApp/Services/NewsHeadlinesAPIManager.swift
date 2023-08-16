//
//  NewsListAPIManager.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation
import PromiseKit
class NewsHeadlinesAPIManager: APIManager {
    
    func getNewsArticles() -> Promise<NewsApiResponse> {
        let endpoint = "\(APIEndPoints.topHeadlines)?country=in"
        return self.request(endpoint, responseType: NewsApiResponse.self)
    }
}
