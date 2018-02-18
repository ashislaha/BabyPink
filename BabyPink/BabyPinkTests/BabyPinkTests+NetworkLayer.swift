//
//  BabyPinkTests+NetworkLayer.swift
//  BabyPinkTests
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import XCTest
@testable import BabyPink

// MARK:- Network layer test cases
extension BabyPinkTests {
    // GET call
    func test12_GetData() {
        let successUrl = "https://httpbin.org/get"
        guard let url = URL(string: successUrl) else { return }
        NetworkLayer.getData(url: url, successBlock: { (response) in
            XCTAssertNotNil(response)
        }, failed: { (error) in
            XCTAssertNil(error)
        })
        let failureUrl = "http://httpbin.org/get1"
        guard let failureURL = URL(string: failureUrl) else { return }
        NetworkLayer.getData(url: failureURL, successBlock: { (response) in
            XCTAssertNil(response)
        }, failed: { (error) in
            XCTAssertNotNil(error)
        })
    }
    
    // update(POST/PUT/DELETE) call
    func test13_UpdateData() {
        let successUrl = "https://httpbin.org/post"
        let bodyDict = ["name": "ashis"]
        NetworkLayer.postData(urlString: successUrl, bodyDict: bodyDict, requestType: .POST, successBlock: { (response) in
            XCTAssertNotNil(response)
        }) { (error) in
            XCTAssertNil(error)
        }
        let failureUrl = "http://httpbin.org/post1"
        NetworkLayer.postData(urlString: failureUrl, bodyDict: bodyDict, requestType: .POST, successBlock: { (response) in
            XCTAssertNil(response)
        }) { (error) in
            XCTAssertNotNil(error)
        }
    }
}

