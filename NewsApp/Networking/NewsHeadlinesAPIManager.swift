//
//  NewsListAPIManager.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation
import PromiseKit
class NewsHeadlinesRequest: BaseRequest {
    
    override init() {
        super.init()
        requestURL = APIEndPoints.baseUrl + APIEndPoints.topHeadlines
        requestQueryParam = "country=in"
    }
}
class NewsHeadlinesAPIManager {
  
    private let apiManager: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getNewsArticles() -> Promise<NewsApiResponse> {
        let request = NewsHeadlinesRequest()
        return apiManager.request(request, responseType: NewsApiResponse.self)
    }
}
