//
//  iewController.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 13/08/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    private var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    // Setup common navigation bar style
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
    
    // Show loading spinner
    func showLoading() {
        if loadingSpinner == nil {
            loadingSpinner = UIActivityIndicatorView(style: .medium)
            loadingSpinner?.center = view.center
            view.addSubview(loadingSpinner)
        }
        loadingSpinner?.startAnimating()
    }
    
    // Hide loading spinner
    func hideLoading() {
        loadingSpinner?.stopAnimating()
    }
    func showAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if actions.isEmpty {
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
        } else {
            for action in actions {
                alertController.addAction(action)
            }
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
