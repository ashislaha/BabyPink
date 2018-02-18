//
//  HomeScreenInteractor.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation

final class HomeScreenInteractor: HomeScreenInteractorProtocol {
    
    var router: HomeScreenRouterProtocol? // strong ref of router
    weak var presenter: HomeScreenPresenterProtocol? // weak ref of presenter
    
    let dataSourceProvider = DataServiceProvider()
    // init
    init(router: HomeScreenRouterProtocol?, presenter: HomeScreenPresenterProtocol?) {
        self.router = router
        self.presenter = presenter
    }
    // fetch categories
    func fetchCategories() {
        do {
            try dataSourceProvider.getCategories { [weak self] (categories) in
                self?.presenter?.getCategories(categories: categories)
            }
        } catch DataSourceError.InvalidURL {
            print("Invalid URL")
        } catch {
            print("Information Insufficient")
        }
    }
    // fetch products
    func fetchProducts(productId: String) {
        do {
            try dataSourceProvider.getProducts(productId: productId, completionHandler: { [weak self] (products) in
                self?.presenter?.getProducts(products: products)
            })
        } catch DataSourceError.InvalidURL {
            print("Invalid URL")
        } catch {
            print("Information Insufficient")
        }
    }
    func intitialiseProductDetailsPage(product: Product, index: Int) {
        router?.intitialiseProductDetailsPage(product: product,index: index)
    }
}

