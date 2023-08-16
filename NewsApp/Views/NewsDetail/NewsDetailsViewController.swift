//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 11/08/23.
//

import UIKit

class NewsDetailsViewController: BaseViewController {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    
    var viewModel: NewsDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        self.title = viewModel.source
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
        publishedLabel.text = viewModel.publishedAt
        if let url = viewModel.imageUrl {
            newsImageView.kf.setImage(with: url)
        }
    }
    
    @IBAction func fullStoryButtonTapped(_ sender: UIButton) {
        if let fullStoryUrl = viewModel.fullStoryUrl {
            UIApplication.shared.open(fullStoryUrl, options: [:], completionHandler: nil)
        }
    }
}
