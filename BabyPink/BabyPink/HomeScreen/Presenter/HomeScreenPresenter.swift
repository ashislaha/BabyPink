//
//  HomeScreenPresenter.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation

final class HomeScreenPresenter: HomeScreenPresenterProtocol {
    
    public var interactor: HomeScreenInteractorProtocol? // Strong hold of Interactor
    weak var homeScreenView: HomeScreenViewProtocol? // Weak hold of View
    // init
    init(view: HomeScreenViewProtocol?){
        homeScreenView = view
    }
    func fetchCategories() {
        interactor?.fetchCategories()
    }
    func getCategories(categories: Categories) {
        homeScreenView?.getCategories(categories: categories)
    }
    func fetchProducts(productId: String) {
        interactor?.fetchProducts(productId: productId)
    }
    func getProducts(products: [Product]) {
        homeScreenView?.getProducts(products: products)
    }
    func intitialiseProductDetailsPage(product: Product, index: Int) {
        interactor?.intitialiseProductDetailsPage(product: product, index: index)
    }
}
