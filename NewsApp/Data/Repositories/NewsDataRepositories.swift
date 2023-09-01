//
//  NewsDataRepositories.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 18/08/23.
//

import Foundation
import PromiseKit

final class NewsHeadlinesRequest: BaseRequest {
    
    override init() {
        super.init()
        requestURL = APIEndPoints.baseUrl + APIEndPoints.topHeadlines
        requestQueryParam = "country=in"
    }
}

final class NewsHeadlinesDataRepository: NewsHeadlinesRepository {
    private let apiService: ServiceProtocol
    
    init(apiService: ServiceProtocol) {
        self.apiService = apiService
    }
    
    func getNewsHeadlines() -> Promise<[NewsArticle]> {
        
        return Promise { seal in
            let request = NewsHeadlinesRequest()
            apiService.request(request, responseType: NewsApiResponseDTO.self)
                .done { response in
                    seal.fulfill(NewsArticleDTOMapper.getArticles(dataApiResponse: response))
                }
                .catch { error in
                    seal.reject(error)
                }
        }
    }
}
