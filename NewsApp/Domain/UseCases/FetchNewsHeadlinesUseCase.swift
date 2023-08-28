//
//  FetchNewsListUseCase.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 18/08/23.
//

import Foundation
import PromiseKit

protocol FetchNewsHeadlinesUseCaseProtocol {
    func execute() -> Promise<[NewsArticle]>
}

class FetchNewsHeadlinesUseCase: FetchNewsHeadlinesUseCaseProtocol {
    private let newsRepository: NewsHeadlinesRepository
 
    init(newsRepository: NewsHeadlinesRepository = NewsHeadlinesDataRepository()) {
        self.newsRepository = newsRepository
    }
    
    func execute() -> Promise<[NewsArticle]> {
        return newsRepository.getNewsHeadlines()
    }
}
