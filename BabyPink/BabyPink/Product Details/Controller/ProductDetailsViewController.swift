//
//  ProductDetailsViewController.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

protocol ProductDetailsProtocol: class { 
    func favouriteSelected(selection: Bool, index: Int)
}

class ProductDetailsViewController: UIViewController {
    
    var model: Product?
    var index: Int = 0
    weak var delegate: ProductDetailsProtocol?
    
    var viewModel = ProductViewModel()
    let activityIndiactor: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.color = Constants.pinkColor
        return spinner
    }()
    
    @IBOutlet weak var topView: TopView! {
        didSet {
            topView.delegate = self
            let existingCount = UserDefaults.standard.value(forKey: Constants.Cart.cartKey) as? Int ?? 0
            topView.model = TopViewModel(leftImageType: .back, title: "Product Details", cartNumber: "\(existingCount)")
        }
    }
    @IBOutlet weak var imageVw: UIImageView! {
        didSet {
            imageVw.addSubview(activityIndiactor)
            activityIndiactor.anchors(centerX: imageVw.centerXAnchor, centerY: imageVw.centerYAnchor)
        }
    }
    @IBOutlet weak var favouriteImageVw: UIImageView! {
        didSet {
            favouriteImageVw.isUserInteractionEnabled = true
            favouriteImageVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favouriteTapped)))
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! { didSet { descriptionLabel.text = "" } }
    @IBOutlet weak var priceLabel: UILabel! { didSet { priceLabel.text = "" } }
    @IBOutlet weak var offerLabel: UILabel! { didSet { offerLabel.text = "" } }
    @IBOutlet weak var addToCardView: UIView! {
        didSet {
            addToCardView.layer.cornerRadius = 10.0
            addToCardView.layer.masksToBounds = true
            addToCardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addToCardViewTapped)))
        }
    }
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var stepCountLabel: UILabel! {
        didSet {
            stepCountLabel.layer.cornerRadius = 5.0
            stepCountLabel.layer.masksToBounds = true
        }
    }
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        let title = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        print(title)
    }
    @IBAction func stepperAction(_ sender: UIStepper) {
        let stepCount = Int(sender.value)
        stepCountLabel.text = "\(stepCount)"
        viewModel.addPulseAnimation(layer: stepCountLabel.layer)
        updateOffer(stepCount: stepCount)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        viewModel.controller = self // holds the weak reference of controller
    }
    private func updateUI() {
        guard let product = model else { return }
        descriptionLabel.text = product.productDescription
        priceLabel.text = "$" + product.skuFinalPrice
        offerLabel.text = product.productOffer
        updateImage(id: product.id)
        favouriteImageVw.image = product.isFavourite ? #imageLiteral(resourceName: "fillHeart") : #imageLiteral(resourceName: "heart")
    }
}
