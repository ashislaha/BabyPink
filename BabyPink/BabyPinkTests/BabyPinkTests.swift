//
//  BabyPinkTests.swift
//  BabyPinkTests
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import XCTest
@testable import BabyPink

class BabyPinkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension BabyPinkTests {
    public func getTestProduct1() -> Product {
        /*
         "product.id": "1113",
         "product.category.id":  "150",
         "product.image.url": "/assets/categories/{product.id}.png",
         "sku.displayName": "Baby Girl",
         "product.displayName": "cool baby clothes Cotton ",
         "product.description": "cool baby clothes Cotton ",
         "product.tag": "SALE",
         "sku.finalPrice": "63",
         "sku.lastPrice": "80",
         "maxQuantity": "99.0",
         "priceStrikeOff": "99",
         "product.offer": {
         "buy": 3,
         "free": 1
         },
         "inventoryTotal": "20",
         "inventoryUsed": "0"
        */
        
        let dict: [String: Any] = [ Constants.Product.id: "1113",
                                    Constants.Product.categoryId: "150",
                                    Constants.Product.imageUrl: "/assets/categories/{product.id}.png",
                                    Constants.Product.skuDisplayName: "Baby Girl",
                                    Constants.Product.productDisplayName: "cool baby clothes Cotton",
                                    Constants.Product.productDescription: "cool baby clothes Cotton",
                                    Constants.Product.productTag: "SALE",
                                    Constants.Product.finalPrice: "63",
                                    Constants.Product.skuLastPrice: "99",
                                    Constants.Product.maximumQuantity: "99",
                                    Constants.Product.priceStrikeOff: "99",
                                    Constants.Product.productOffer: [ Constants.Product.buy: 3, Constants.Product.free: 1],
                                    Constants.Product.inventoryTotal: "20",
                                    Constants.Product.inventoryUsed: "0"
        ]
        return Product(dict: dict)
    }
    
    public func getTestProduct2() -> Product {
        /*
         "product.id": "1113",
         "product.category.id":  "150",
         "product.image.url": "/assets/categories/{product.id}.png",
         "sku.displayName": "Baby Girl",
         "product.displayName": "cool baby clothes Cotton ",
         "product.description": "cool baby clothes Cotton ",
         "product.tag": "",
         "sku.finalPrice": "63",
         "sku.lastPrice": "80",
         "maxQuantity": "99.0",
         "priceStrikeOff": "99",
         "inventoryTotal": "20",
         "inventoryUsed": "16"
         */
        
        let dict: [String: Any] = [ Constants.Product.id: "1113",
                                    Constants.Product.categoryId: "150",
                                    Constants.Product.imageUrl: "/assets/categories/{product.id}.png",
                                    Constants.Product.skuDisplayName: "Baby Girl",
                                    Constants.Product.productDisplayName: "cool baby clothes Cotton",
                                    Constants.Product.productDescription: "cool baby clothes Cotton",
                                    Constants.Product.productTag: "",
                                    Constants.Product.finalPrice: "63",
                                    Constants.Product.skuLastPrice: "99",
                                    Constants.Product.maximumQuantity: "99",
                                    Constants.Product.priceStrikeOff: "99",
                                    Constants.Product.inventoryTotal: "20",
                                    Constants.Product.inventoryUsed: "16"
        ]
        return Product(dict: dict)
    }
}
