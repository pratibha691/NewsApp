//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import Foundation
import UIKit

class NewsHeadlinesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerNib(nibName: HeadlinesTableViewCell.self)
        }
    }
    
    var viewModel = NewsHeadlinesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NAConstants.headlineTitle
        fetchNewsArticles()
    }
    
    private func fetchNewsArticles() {
        showLoading()
        viewModel.fetchNewsArticles { [weak self] error in
            self?.hideLoading()
            if let error = error {
                self?.showAlert(title: NAConstants.Error.errorTitle, message: "\(error.localizedDescription)")
            } else {
                self?.tableView.reloadData()
            }
        }
    }
}

extension NewsHeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HeadlinesTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
        if let article = viewModel.article(at: indexPath.row) {
            // Configure the cell with the article data
            cell.configure(with: article)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = viewModel.article(at: indexPath.row) else {
            return
        }
        let newsDetailsVC: NewsDetailsViewController = NewsDetailsViewController.instantiateFromStoryboard(named: .main)
        newsDetailsVC.viewModel = NewsDetailsViewModel(newsArticle: article)
        navigationController?.pushViewController(newsDetailsVC, animated: true)
    }
}
