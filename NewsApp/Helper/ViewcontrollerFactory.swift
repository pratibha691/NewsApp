//
//  ViewcontrollerFactory.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 29/08/23.
//

import Foundation

class ViewControllerFactory {
    
    static func createNewsHeadlinesViewController() -> NewsHeadlinesViewController {
       let newsHeadlinesVC: NewsHeadlinesViewController = NewsHeadlinesViewController.instantiateFromStoryboard(named: .main)
        let useCase = FetchNewsHeadlinesUseCase()
        let viewModel = NewsHeadlinesViewModel(newsHeadlinesUseCase: useCase)
        newsHeadlinesVC.viewModel = viewModel
        return newsHeadlinesVC
    }
    
    static func createNewsDetailsViewController(viewModel: NewsDetailsViewModel) -> NewsDetailsViewController {
       let newsDetailVC: NewsDetailsViewController = NewsDetailsViewController.instantiateFromStoryboard(named: .main)
        newsDetailVC.viewModel = viewModel
       return newsDetailVC
    }
}
