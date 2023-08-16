//
//  MockAPIManager.swift
//  NewsAppTests
//
//  Created by Pratibha Gupta on 16/08/23.
//

import Foundation
import PromiseKit
class MockAPIManager {
    
    static func loadMockResponse<T: Decodable>(from fileName: String) -> Promise<T> {
         return Promise { seal in
             if let filePath = Bundle.main.path(forResource: fileName, ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
                 do {
                     let decoder = JSONDecoder()
                     let response = try decoder.decode(T.self, from: data)
                     seal.fulfill(response)
                 } catch {
                     seal.reject(error)
                 }
             } else {
                 let error = NSError(domain: "MockAPIManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Mock JSON file not found"])
                 seal.reject(error)
             }
         }
     }
}
