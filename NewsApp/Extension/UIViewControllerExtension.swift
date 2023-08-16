//
//  UIViewControllerExtension.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 13/08/23.
//

import Foundation
import UIKit

extension UIViewController {
    enum StoryboardName: String {
        case main = "Main"
        // Add more storyboard names here as needed
    }
    
    static func instantiateFromStoryboard<T: UIViewController>(named storyboardName: StoryboardName = .main, identifier: String? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let viewControllerIdentifier = identifier ?? String(describing: T.self)
        if let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? T {
            return viewController
        } else {
            fatalError("Failed to instantiate view controller from storyboard.")
        }
    }
}
