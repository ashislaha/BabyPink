//
//  HomeScreen.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation
import UIKit

protocol HomeScreenBuilderProtocol {
    func buildHomeScreenModule() -> HomeScreenViewController?
}

protocol HomeScreenViewProtocol: class {
    func getCategories(categories: Categories)
    func getProducts(products: [Product])
    func updateFavourite(selection: Bool, productIndex: Int)
}

protocol HomeScreenPresenterProtocol: class {
    func fetchCategories()
    func getCategories(categories: Categories)
    func fetchProducts(productId: String)
    func getProducts(products: [Product])
    func intitialiseProductDetailsPage(product: Product, index: Int)
}

protocol HomeScreenInteractorProtocol: class {
    func fetchCategories()
    func fetchProducts(productId: String)
    func intitialiseProductDetailsPage(product: Product, index: Int)
}

protocol HomeScreenRouterProtocol: class {
    func intitialiseProductDetailsPage(product: Product, index: Int)
}
