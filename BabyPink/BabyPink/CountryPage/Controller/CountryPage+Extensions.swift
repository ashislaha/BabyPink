//
//  CountryPage+Extensions.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

extension CountryPageViewController {
    @objc func countryTapped() {
        respondingDropDown = .country
        configureDropDownOptionsView(title: Constants.CountryPage.countryInfo, model: Constants.CountryPage.countries)
        shadowView.isHidden = false
    }
    @objc func cityTapped() {
        guard respondingDropDown != .none && isCountrySelected else { return } // don't allow for the first time
        respondingDropDown = .city
        configureDropDownOptionsView(title: Constants.CountryPage.cityInfo, model: Constants.CountryPage.countriesDict[countryView.labelInfo ?? ""] ?? [])
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
    @objc func applyTapped() {
        guard respondingDropDown != .none && isCitySelected else { return }
        if let vc = HomeScreenBuilder().buildHomeScreenModule() {
            present(vc, animated: true, completion: nil)
        }
    }
    @objc func shadowViewTapped() {
        if dropDownOptionsView != nil { dropDownOptionsView.removeFromSuperview() }
        shadowView.isHidden = true
    }
}

extension CountryPageViewController: DropDownProtocol {
    func select(name: String, indexPath: IndexPath) {
        switch respondingDropDown {
        case .country:
            countryView.labelInfo = name
            isCountrySelected = true
            isCitySelected = false // select city again
            cityView.labelInfo = Constants.CountryPage.cityInfo
        case .city:
            cityView.labelInfo = name
            isCitySelected = true
        case .none: break
        }
        dropDownOptionsView.removeFromSuperview()
        shadowView.isHidden = true
    }
}
    

