//
//  DataServiceProvider.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation

// MARK:- DataSourceError
enum DataSourceError: Error {
    case InvalidURL
    case CategoriesGenererationError
    case ErrorInServerData
}

final class DataServiceProvider {
    
    // get categories (using JSONDecoder)
    func getCategories(completionHandler: @escaping ((Categories)->())) throws {
        let categoriesEndPoint = Constants.DataService.endPoint + "/categories.json"
        guard let url = URL(string: categoriesEndPoint) else { throw DataSourceError.InvalidURL }
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            guard let categories = try? JSONDecoder().decode(Categories.self, from: data) else { return }
            DispatchQueue.main.async {
                completionHandler(categories)
            }
        }
        session.resume()
    }
    
    // get products details
    func getProducts(productId: String, completionHandler: @escaping (([Product])->())) throws {
        let urlStr = Constants.DataService.endPoint + "/products/products.\(productId).json"
        guard let url = URL(string: urlStr), !urlStr.isEmpty else { throw DataSourceError.InvalidURL }
        
        NetworkLayer.getData(url: url, successBlock: { (response) in
            // success
            DispatchQueue.main.async {
                guard let response = response as? [String: Any], let records = response[Constants.Products.records] as? [[String:Any]], !records.isEmpty else { return }
                let record = Record(dict: records[0])
                if let products = record.attributes?.records {
                    completionHandler(products)
                }
            }
        }) { (error) in
            print(error.debugDescription)
        }
    }
}
