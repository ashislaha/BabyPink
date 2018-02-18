//
//  HomeScreenVC+extensions.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

// MARK:- HomeScreenViewProtocol (communication channel with Presenter and rest of VIPER module)
extension HomeScreenViewController: HomeScreenViewProtocol {
    func getCategories(categories: Categories) {
        self.categories = categories
        categoryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTapped)))
    }
    func getProducts(products: [Product]) {
        self.products = products
        productListView.model = products
    }
    func updateFavourite(selection: Bool, productIndex: Int){
        products[productIndex].isFavourite = selection
    }
}

// MARK:- ProductListProtocol (communicating with Product List View)
extension HomeScreenViewController: ProductListProtocol {
    func itemSelected(model: Product, index: Int) {
        presenter?.intitialiseProductDetailsPage(product: model, index: index)
    }
}

// MARK:- Drop Down protocol
extension HomeScreenViewController: DropDownProtocol {
    func select(name: String, indexPath: IndexPath) {
        categoryView.labelInfo = name
        dropDownOptionsView.removeFromSuperview()
        shadowView.isHidden = true
        if let productId = categories?.contents[indexPath.row].id {
            presenter?.fetchProducts(productId: "\(productId)")
        }
    }
}

// MARK:- TopViewProtocol
extension HomeScreenViewController: TopViewProtocol {
    func leftImageTapped(type: LeftImageType) {
        print("open menu")
    }
}

// MARK:- HomeScreenViewController utilities
extension HomeScreenViewController {
    @objc func categoryTapped() {
        guard let categories = categories, !categories.contents.isEmpty else { return }
        // filter active categories and then map into category names
        let categoryNameList =  categories.contents.filter{ $0.active }.map{ $0.displayName }
        configureDropDownOptionsView(title: Constants.HomePage.selectCategory, model: categoryNameList)
        shadowView.isHidden = false
    }
    private func configureDropDownOptionsView(title: String, model: [String]) {
        dropDownOptionsView = DropDownOptionsView(frame: .zero)
        view.addSubview(dropDownOptionsView)
        dropDownOptionsView.translatesAutoresizingMaskIntoConstraints = false
        dropDownOptionsView.model = model
        dropDownOptionsView.delegate = self
        dropDownOptionsView.headerTitle = title
        dropDownOptionsView.layer.cornerRadius = 10.0
        dropDownOptionsView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            dropDownOptionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            dropDownOptionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            dropDownOptionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            dropDownOptionsView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25) // 25% view height
            ])
    }
    @objc func shadowViewTapped() {
        if dropDownOptionsView != nil { dropDownOptionsView.removeFromSuperview() }
        shadowView.isHidden = true
    }
}
