//
//  BabyPinkTests+ProductDetailsVC.swift
//  BabyPinkTests
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import XCTest
@testable import BabyPink

// MARK:-  ProductDetailsViewController

extension BabyPinkTests {
    
    func test5_OfferLabelTextInProductDetailsPage() { // some offer
        guard let productDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else { return }
        
        productDetailsVC.model = getTestProduct1()
        _ = productDetailsVC.view // This is very Important line to initialise your view hierarchy, else all outlets might not be set yet, getting nil value.
        
        let offerString = productDetailsVC.getOfferLabelText()
        XCTAssertNotNil(offerString) // input is valid
        XCTAssertEqual(offerString!, "BUY 3 GET 1 FREE\n") // "\n" is appended while data is parsing
        
        productDetailsVC.updateOffer(stepCount: 1) // stepper count value is 1
        let offerStringTwo = productDetailsVC.getOfferLabelText()
        XCTAssertNotNil(offerStringTwo) // input is valid
        XCTAssertEqual(offerStringTwo!, "Add 2 items to avail 1 item FREE") // added 2 more items to get 1 item free
        
        productDetailsVC.updateOffer(stepCount: 3) // stepper count value is 3
        let offerStringThree = productDetailsVC.getOfferLabelText()
        XCTAssertNotNil(offerStringThree) // input is valid
        XCTAssertEqual(offerStringThree!, "Congratulations !!! You avail 1 FREE item") // stepper count value >= buy value
    }
    
    func test6_OfferLabelTextInProductDetailsPage() { // No offer
        guard let productDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else { return }
        
        productDetailsVC.model = getTestProduct2()
        _ = productDetailsVC.view // This is very Important line to initialise your view hierarchy, else all outlets might not be set yet, getting nil value.
        let offerString = productDetailsVC.getOfferLabelText()
        XCTAssertEqual(offerString!, "") // There is no offer
    }
    
    func test7_DescriptionLabelText() {
        guard let productDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else { return }
        
        productDetailsVC.model = getTestProduct1()
        _ = productDetailsVC.view // to load view hierarchy
        let desc = productDetailsVC.getDescriptionLabelText()
        XCTAssertNotNil(desc)
        XCTAssertEqual(desc!, "cool baby clothes Cotton")
    }
    
    func test8_PriceLabelText() {
        guard let productDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else { return }
        
        productDetailsVC.model = getTestProduct1()
        _ = productDetailsVC.view // to load view hierarchy
        let price = productDetailsVC.getPriceLabelText()
        XCTAssertNotNil(price)
        XCTAssertEqual(price!, "$63")
    }
    
    func test9_StepperCountLabelText() {
        guard let productDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else { return }
        
        productDetailsVC.model = getTestProduct1()
        _ = productDetailsVC.view // to load view hierarchy
        let stepperCount = productDetailsVC.getStepperCount()
        XCTAssertNotNil(stepperCount)
        XCTAssertEqual(stepperCount!, "0")
    }
}
