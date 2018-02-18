//
//  AppUtil.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

struct Constants {
    static let pinkColor = UIColor(red: 255.0/255.0, green: 90.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    struct CountryPage {
        static let baby = "baby"
        static let pink = "pink"
        static let countriesDict: [String: [String]] = [
            "India": ["Kolkata", "Delhi", "Mumbai", "Bangalore", "Chennai"],
            "USA": ["New York City", "Chicogo", "Washington D.C.", "Los Angeles", "Seattle", "Boston", "San Francisco"],
            "Canada": ["Toronto", "Montreal", "Ottawa", "Calgary", "Vancouver"]
        ]
        static let countries = ["India", "USA", "Canada"]
        static let countryInfo = "Select Country"
        static let cityInfo = "Select City"
    }
    struct DropDown {
        static let dropDownCell = "dropDownCell"
        static let dropDownHeader = "dropDownHeader"
    }
    struct HomePage {
        static let backGroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        static let categories = "Categories"
        struct ProductListView {
            static let productCell = "productCell"
        }
        static let selectCategory = "Select Category"
    }
    struct Cart {
        static let cartKey = "cartKey"
    }
    struct DataService {
        static let endPoint = "http://static-data.surge.sh"
        static let defaultProductsEndPoint = "http://static-data.surge.sh/products/products.101.json" // Baby-Boy
        
    }
    struct Products {
        static let records = "records"
    }
    struct Records {
        static let numberOfRecords = "numRecords"
        static let attributes = "attributes"
    }
    struct Attributes {
        static let brand = "Brand"
        static let skuUnitOfMeasure = "sku.unit_of_measure"
        static let records = "records"
    }
    struct Product {
        static let id = "product.id"
        static let categoryId = "product.category.id"
        static let imageUrl = "product.image.url"
        static let skuDisplayName = "sku.displayName"
        static let productDisplayName = "product.displayName"
        static let productDescription = "product.description"
        static let productTag = "product.tag"
        static let finalPrice = "sku.finalPrice"
        static let skuLastPrice = "sku.lastPrice"
        static let maximumQuantity = "maxQuantity"
        static let inventoryTotal = "inventoryTotal"
        static let inventoryUsed = "inventoryUsed"
        static let priceStrikeOff = "priceStrikeOff"
        static let productOffer = "product.offer"
        static let buy = "buy"
        static let free = "free"
    }
}

enum RespondingDropDown {
    case country
    case city
    case none
}
