//
//  ProductListView.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

protocol ProductListProtocol: class {
    func itemSelected(model: Product, index: Int)
}

class ProductListView: UIView {
    private var collectionView: UICollectionView!
    public weak var delegate: ProductListProtocol?
    public var model: [Product] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewSetUp()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSetUp()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK:- setup collectionView
    private func collectionViewSetUp() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionCell.self, forCellWithReuseIdentifier: Constants.HomePage.ProductListView.productCell)
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
    }
}
