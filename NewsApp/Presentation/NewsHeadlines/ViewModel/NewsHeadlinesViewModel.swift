//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation
import PromiseKit

protocol NewsHeadlinesViewModelProtocol {
    func fetchNewsArticles()
    func numberOfRows() -> Int
    func getCellViewModel(at index: Int) -> NewsHeadlinesCellViewModel?
    func getNewDetailViewModel(at index: Int) -> NewsDetailsViewModel?
    var newsArticles: Observable<[NewsArticle]> { get }
    var errorMessage: Observable<String> { get }
}
final class NewsHeadlinesViewModel: NewsHeadlinesViewModelProtocol {
    
    // MARK: - Properties
    
    var newsArticles: Observable<[NewsArticle]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    
    // MARK: - Dependencies
    
     let newsHeadlinesUseCase: FetchNewsHeadlinesUseCaseProtocol
    
    // MARK: - Initialization
    
    init(newsHeadlinesUseCase: FetchNewsHeadlinesUseCaseProtocol) {
        self.newsHeadlinesUseCase = newsHeadlinesUseCase
    }
    
    // MARK: - Public Methods
    
    func fetchNewsArticles() {
        newsHeadlinesUseCase.execute()
            .done { [weak self] articles in
                self?.newsArticles.value = articles
            }
            .catch { error in
                self.errorMessage.value = error.localizedDescription
            }
    }
    
    func numberOfRows() -> Int {
        return newsArticles.value.count
    }
    
    func article(at index: Int) -> NewsArticle? {
        guard index < numberOfRows() else {
            return nil
        }
        return newsArticles.value[index]
    }
    
    func getCellViewModel(at index: Int) -> NewsHeadlinesCellViewModel? {
        if let article = article(at: index) {
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
