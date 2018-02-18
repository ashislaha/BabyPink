//
//  ViewController.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

class CountryPageViewController: UIViewController {
    
    @IBOutlet weak private var titleLabel: UILabel! {
        didSet{
            let attributedString = NSMutableAttributedString(string: Constants.CountryPage.baby, attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            let pinkAttributedString = NSAttributedString(string: Constants.CountryPage.pink, attributes: [
                NSAttributedStringKey.foregroundColor: Constants.pinkColor,
                ])
            attributedString.append(pinkAttributedString)
            titleLabel.attributedText = attributedString
        }
    }
    @IBOutlet weak var countryView: DropDownUI! {
        didSet {
            countryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(countryTapped)))
            countryView.labelInfo = Constants.CountryPage.countryInfo
        }
    }
    @IBOutlet weak var cityView: DropDownUI! {
        didSet {
            cityView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cityTapped)))
            cityView.labelInfo = Constants.CountryPage.cityInfo
        }
    }
    @IBOutlet weak private var applyView: UIView! {
        didSet {
            applyView.layer.cornerRadius = 10.0
            applyView.layer.masksToBounds = true
            applyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applyTapped)))
        }
    }
    var respondingDropDown: RespondingDropDown = .none
    var dropDownOptionsView: DropDownOptionsView! 
    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.isHidden = true
        return view
    }()
    var isCountrySelected: Bool = false
    var isCitySelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureShadowView()
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
}
