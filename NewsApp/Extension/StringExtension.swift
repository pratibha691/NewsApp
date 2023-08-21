//
//  StringExtension.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 11/08/23.
//

import Foundation
extension String {
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
extension Optional where Wrapped == String {
    func orEmpty() -> String {
        return self ?? ""
    }
}
