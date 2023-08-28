//
//  NewsListRepository.swift
//  NewsApp
//
//  Created by Pratibha Gupta on 18/08/23.
//

import Foundation
import PromiseKit

protocol NewsHeadlinesRepository {
    func getNewsHeadlines() -> Promise<[NewsArticle]>
}
