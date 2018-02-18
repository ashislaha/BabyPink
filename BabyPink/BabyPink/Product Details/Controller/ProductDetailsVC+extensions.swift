//
//  ProductDetailsVC+extensions.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

extension ProductDetailsViewController {
    
    func updateOffer(stepCount: Int) {
        guard let product = model, !product.productOffer.isEmpty else { return }
        switch stepCount {
        case 0: offerLabel.text = product.productOffer
        case let x where x > 0 && x < product.buy: viewModel.showOfferAvailMessage(x: x,product: product)
        case let x where x >= product.buy: viewModel.showCongratsMessage(x: x, product: product)
        default: break
        }
    }
    func updateImage(id: String) {
        viewModel.updateImage(id: id)
    }
    @objc func addToCardViewTapped() {
        viewModel.addCartTapped()
    }
    @objc func favouriteTapped() {
        viewModel.favouriteTapped()
    }
}

// MARK:-  TopViewProtocol
extension ProductDetailsViewController: TopViewProtocol {
    func leftImageTapped(type: LeftImageType) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- Used for Unit testing
extension ProductDetailsViewController {
    func getOfferLabelText() -> String? {
        return offerLabel.text
    }
    func getDescriptionLabelText() -> String? {
        return descriptionLabel.text
    }
    func getPriceLabelText() -> String? {
        return priceLabel.text
    }
    func getStepperCount() -> String? {
        return stepCountLabel.text
    }
}
