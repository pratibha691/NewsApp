//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 10/08/23.
//

import UIKit
import Kingfisher
class HeadlinesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with viewModel: NewsHeadlinesCellViewModel) {
        headingLabel.text = viewModel.title
        sourceLabel.text = "  \(viewModel.source)  "
        if let imageUrl = viewModel.imageUrl {
            newsImageView.kf.setImage(with: imageUrl)
        }
        dateLabel.text = viewModel.publishedDate
    }
}
