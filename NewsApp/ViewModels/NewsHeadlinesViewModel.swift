//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation
class NewsHeadlinesViewModel {
    
    var newsArticles: [NewsArticle] = []
    var apiManager = NewsHeadlinesAPIManager()

    func fetchNewsArticles(completion: @escaping (Error?) -> Void) {
        apiManager.getNewsArticles()
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
}
