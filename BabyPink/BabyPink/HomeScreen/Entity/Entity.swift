//
//  Entity.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation

// categories
struct Category: Decodable {
    let displayName: String
    let id: Int
    let active: Bool
}

// MARK:- Category conforming Equatable protocol
extension Category: Equatable {
    public static func == (lhs: Category, rhs: Category) -> Bool {
        
        if lhs.displayName == rhs.displayName &&
            lhs.id == rhs.id &&
            lhs.active == rhs.active {
            return true
        }
        return false
    }
}

// MARK:- Categories
struct Categories: Decodable {
    let displayName: String
    let type: String? // not able parse it using Decodable because the keyname is "@type" which isn't supported by xcode, can be done using JSONSerialization.
    let contents: [Category]
}

// MARK:- Record
struct Record {
    let numRecords: Int
    let attributes: Attributes?
    
    init(dict: [String: Any]) {
        numRecords = dict[Constants.Records.numberOfRecords] as? Int ?? 0
        if let attributesDict = dict[Constants.Records.attributes] as? [String: Any] {
            attributes = Attributes(dict: attributesDict)
        } else {
            attributes = nil
        }
    }
}

struct Attributes {
    let brand: String
    let skuUnitOfMeasure: String
    var records: [Product]
    
    init(dict: [String: Any]) {
        brand = dict[Constants.Attributes.brand] as? String ?? ""
        skuUnitOfMeasure = dict[Constants.Attributes.skuUnitOfMeasure] as? String ?? ""
        records = []
        if let products = dict[Constants.Attributes.records] as? [[String:Any]], !products.isEmpty {
            for eachProduct in products {
                records.append(Product(dict: eachProduct))
            }
        }
    }
}

// MARK:- Product
struct Product {
    let id: String
    let categoryId: String
    let imageUrl: String
    let skuDisplayName: String
    let productDisplayName: String
    let productDescription: String
    let productTag: String
    let skuFinalPrice: String
    let skuLastPrice: String
    let maxQuantity: String
    let inventoryTotal: String
    let inventoryUsed: String
    let priceStrikeOff: String
    let productOffer: String
    let buy: Int
    let free: Int
    var isFavourite: Bool = false // change once user tapped on favourite heart button
    
    init(dict: [String: Any]) {
        id = dict[Constants.Product.id] as? String ?? ""
        categoryId = dict[Constants.Product.categoryId] as? String ?? ""
        imageUrl = dict[Constants.Product.imageUrl] as? String ?? ""
        skuDisplayName = dict[Constants.Product.skuDisplayName] as? String ?? ""
        productDisplayName = dict[Constants.Product.productDisplayName] as? String ?? ""
        productDescription = dict[Constants.Product.productDescription] as? String ?? ""
        productTag = dict[Constants.Product.productTag] as? String ?? ""
        skuFinalPrice = dict[Constants.Product.finalPrice] as? String ?? ""
        skuLastPrice = dict[Constants.Product.skuLastPrice] as? String ?? ""
        maxQuantity = dict[Constants.Product.maximumQuantity] as? String ?? ""
        inventoryTotal = dict[Constants.Product.inventoryTotal] as? String ?? ""
        inventoryUsed = dict[Constants.Product.inventoryUsed] as? String ?? ""
        priceStrikeOff = dict[Constants.Product.priceStrikeOff] as? String ?? ""
        if let offers = dict[Constants.Product.productOffer] as? [String: Any] {
            buy = offers[Constants.Product.buy] as? Int ?? 1
            free = offers[Constants.Product.free] as? Int ?? 1
            productOffer = "BUY \(buy) GET \(free) FREE\n"
        } else {
            productOffer = ""
            buy = 0
            free = 0
        }
    }
}
