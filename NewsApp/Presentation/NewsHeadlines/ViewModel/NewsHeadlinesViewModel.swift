//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation
import PromiseKit
class NewsHeadlinesViewModel {
    
    var newsArticles: [NewsArticle] = []

    let newsHeadlinesUseCase: FetchNewsHeadlinesUseCase
    
    init(newsHeadlinesUseCase: FetchNewsHeadlinesUseCase = FetchNewsHeadlinesUseCase()) {
        self.newsHeadlinesUseCase = newsHeadlinesUseCase
    }
    
    func fetchNewsArticles(completion: @escaping (Error?) -> Void) {
         newsHeadlinesUseCase.execute()
            .done { [weak self] articles in
                self?.newsArticles = articles.articles ?? []
                completion(nil)
            }
            .catch { error in
                completion(error)
            }
    }
    func numberOfRows() -> Int {
        return newsArticles.count
    }
    func article(at index: Int) -> NewsArticle? {
        guard  index < newsArticles.count else {
            return nil
        }
        return newsArticles[index]
    }
    func getCellViewModel(at index: Int) -> NewsHeadlinesCellViewModel? {
        if  let article = article(at: index) {
            return NewsHeadlinesCellViewModel(article: article)
        }
        return nil
    }
    func getNewDetailViewModel(at index: Int) -> NewsDetailsViewModel? {
        if let article = article(at: index) {
            return NewsDetailsViewModel(newsArticle: article)
        }
        return nil
    }
}
