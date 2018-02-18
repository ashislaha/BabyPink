//
//  HomeScreenRouter.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

final class HomeScreenRouter: HomeScreenRouterProtocol {
    
    weak var viewController: HomeScreenViewController? // weak reference
    
    init(viewController: HomeScreenViewController?) {
        self.viewController = viewController
    }
    func intitialiseProductDetailsPage(product: Product, index: Int) {
        guard let productPageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else { return }
        productPageVC.model = product
        productPageVC.delegate = self
        productPageVC.index = index
        viewController?.present(productPageVC, animated: true, completion: nil)
    }
}

extension HomeScreenRouter: ProductDetailsProtocol {
    func favouriteSelected(selection: Bool, index: Int) { // update the favourite selection state into the model
        viewController?.updateFavourite(selection: selection, productIndex: index)
    }
}
