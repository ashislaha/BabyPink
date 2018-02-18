//
//  BabyPinkTests+Entity.swift
//  BabyPinkTests
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import XCTest
@testable import BabyPink

// MARK:-  Entity
extension BabyPinkTests {
    
    func test10_createProduct() {
        let testProduct1 = getTestProduct1()
        let testProduct2 = getTestProduct2()
        XCTAssertNotEqual(testProduct1, testProduct2) // both are not equal
        XCTAssertEqual(testProduct1, testProduct1) // both are same
    }
    
    func test11_createCategory() {
        let category1 = Category(displayName: "Baby Boy", id: 101, active: true)
        let category2 = Category(displayName: "Baby Girl", id: 150, active: true)
        let category3 = Category(displayName: "Home & Kitchen", id: 502, active: false)
        XCTAssertNotEqual(category1, category2) // category is conforming Equatable protocol
        XCTAssertNotEqual(category2, category3)
        XCTAssertEqual(category1, category1)
    }
}

// MARK:-  Product conforming Equatable
extension Product: Equatable {
    public static func == (lhs: Product, rhs: Product) -> Bool {
        
        if lhs.id == rhs.id &&
            lhs.categoryId == rhs.categoryId &&
            lhs.imageUrl == rhs.imageUrl &&
            lhs.skuDisplayName == rhs.skuDisplayName &&
            lhs.productDisplayName == rhs.productDisplayName &&
            lhs.productDescription == rhs.productDescription &&
            lhs.productTag == rhs.productTag &&
            lhs.skuFinalPrice == rhs.skuFinalPrice &&
            lhs.skuLastPrice == rhs.skuLastPrice &&
            lhs.maxQuantity == rhs.maxQuantity &&
            lhs.inventoryTotal == rhs.inventoryTotal &&
            lhs.inventoryUsed == rhs.inventoryUsed &&
            lhs.priceStrikeOff == rhs.priceStrikeOff &&
            lhs.productOffer == rhs.productOffer &&
            lhs.buy == rhs.buy &&
            lhs.free == rhs.free &&
            lhs.isFavourite == rhs.isFavourite {
            return true
        }
        return false
    }
}

