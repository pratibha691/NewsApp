//
//  NewsDataRepositories.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 18/08/23.
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

class NewsHeadlinesDataRepository: NewsHeadlinesRepository {
    private let apiService: ServiceProtocol
    
    init(apiService: ServiceProtocol = APIManager()) {
        self.apiService = apiService
    }
    
    func getNewsHeadlines() -> Promise<NewsApiResponse> {
        let request = NewsHeadlinesRequest()
        return apiService.request(request, responseType: NewsApiResponse.self)
    }
}
