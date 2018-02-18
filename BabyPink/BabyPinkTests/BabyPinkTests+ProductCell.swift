//
//  BabyPinkTests+ProductCell.swift
//  BabyPinkTests
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import XCTest
@testable import BabyPink

// MARK:-  ProductCollectionCell
extension BabyPinkTests {

    func test1_TagLabelText() {
        let cell = ProductCollectionCell()
        cell.model = getTestProduct1() // this will call updateUI() methods which internally calls all the private nmethods and render the UI components
        let tagVal = cell.getTagLabelText()
        XCTAssertNotNil(tagVal) // must be not nil as input is valid
        XCTAssertEqual(tagVal!, " SALE") // added an empty space at the begining for visualisation
        
        cell.model = getTestProduct2()
        let tag = cell.getTagLabelText()
        XCTAssertNotNil(tag) // must be not nil as input is valid
        XCTAssertEqual(tag!, " Only 4 Left ") // added an empty space at the begining and ending position for visualisation
    }
    
    func test2_DescriptionText() {
        let cell = ProductCollectionCell()
        cell.model = getTestProduct1() // this will call updateUI() methods which internally calls all the private nmethods and render the UI components
        let descriptionOne = cell.getDescriptionText()
        XCTAssertNotNil(descriptionOne) // must be not nil as input is valid
        XCTAssertEqual(descriptionOne!, "BUY 3 GET 1 FREE\ncool baby clothes Cotton") // offer and description is seperated by "\n"
        
        cell.model = getTestProduct2()
        let descriptionTwo = cell.getDescriptionText()
        XCTAssertNotNil(descriptionTwo) // must be not nil as input is valid
        XCTAssertEqual(descriptionTwo!, "cool baby clothes Cotton")
    }
    
    func test3_PriceLabelText() {
        let cell = ProductCollectionCell()
        cell.model = getTestProduct1() // this will call updateUI() methods which internally calls all the private nmethods and render the UI components
        let price = cell.getPriceLabel()
        XCTAssertNotNil(price) // must be not nil as input is valid
        XCTAssertEqual(price!, "$63")
    }
    
    func test4_StrikeThroughText() {
        let cell = ProductCollectionCell()
        cell.model = getTestProduct1() // this will call updateUI() methods which internally calls all the private nmethods and render the UI components
        let strikeThroughPrice = cell.getStrikeThroughText()
        XCTAssertNotNil(strikeThroughPrice) // must be not nil as input is valid
        XCTAssertEqual(strikeThroughPrice!, "$99") 
    }
}
