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
    
    func configure(with article: NewsArticle) {
        headingLabel.text = article.title
        sourceLabel.text = "  \(article.source.name.capitalized)  "
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            newsImageView.kf.setImage(with: url)
        }
        dateLabel.text = article.publishedAt?.valueOrEmpty.formattedDate()
    }
}
