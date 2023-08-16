//
//  UITableViewExtension.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 11/08/23.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNib<T: UITableViewCell>(nibName: T.Type) {
        let nibName = String(describing: nibName)
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: nibName)
    }
    func dequeueCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(reuseIdentifier)")
        }
        return cell
    }
}
