//
//  HomeScreenViewController.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    var presenter: HomeScreenPresenterProtocol? // strong hold of presenter
    var categories: Categories?
    var dropDownOptionsView: DropDownOptionsView!
    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.isHidden = true
        return view
    }()
    var products: [Product] = []
    
    @IBOutlet weak var topView: TopView! {
        didSet {
            topView.delegate = self
            updateTopViewModel()
        }
    }
    @IBOutlet weak var categoryView: DropDownUI! { didSet { categoryView.labelInfo = Constants.HomePage.categories } }
    @IBOutlet weak var productListView: ProductListView! { didSet { productListView.delegate = self } }
    
    // view controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.HomePage.backGroundColor
        presenter?.fetchCategories()
        presenter?.fetchProducts(productId: "101") // default "Baby boy"
        configureShadowView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reachabilityCheck()
        updateTopViewModel()
        if !products.isEmpty { // refresh the collection view so that next time it updates the favourite correctly
            productListView.model = products
        }
    }
    private func updateTopViewModel() {
        let existingCount = UserDefaults.standard.value(forKey: Constants.Cart.cartKey) as? Int ?? 0
        topView.model = TopViewModel(leftImageType: .menu, title: "Featured Item", cartNumber: "\(existingCount)")
    }
    private func configureShadowView() {
        view.addSubview(shadowView)
        shadowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shadowViewTapped)))
        shadowView.layer.cornerRadius = 10.0
        shadowView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            shadowView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            shadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            shadowView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75) // 75% view height
            ])
    }
    
    /*
        There will be a Reachability Notification Observer who observes the network reachability status, once reachability is active, fire the API and
        update the UI.
    */
    private func reachabilityCheck() {
        if !ReachabilityHelper.isInternetAvailable() {
            let alert = UIAlertController(title: "No Internet", message: "Please connect to Internet", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: { (button) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
}
