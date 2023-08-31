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
    
    var viewModel: NewsHeadlinesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NAConstants.headlineTitle
        fetchNewsArticles()
    }
    
    private func fetchNewsArticles() {
        showLoading()
        viewModel.newsArticles.bind { [weak self] _ in
            self?.hideLoading()
            self?.tableView.reloadData()
        }
        viewModel.errorMessage.bind { [weak self] error in
            self?.hideLoading()
            self?.showAlert(title: NAConstants.Error.errorTitle, message: "\(error)")
        }
        viewModel.fetchNewsArticles()
        
    }
}

// MARK: - TableView Delegates and DataSource 

extension NewsHeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HeadlinesTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
        if let cellViewModel = viewModel.getCellViewModel(at: indexPath.row) {
            // Configure the cell with the article data
            cell.configure(with: cellViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewModel = viewModel.getNewDetailViewModel(at: indexPath.row) else {
            return
        }
        
        let newsDetailsVC: NewsDetailsViewController = ViewControllerFactory.createNewsDetailsViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(newsDetailsVC, animated: true)
    }
}
