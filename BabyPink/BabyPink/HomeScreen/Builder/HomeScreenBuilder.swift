//
//  HomeScreenBuilder.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import Foundation
import UIKit

struct HomeScreenBuilder: HomeScreenBuilderProtocol {
    func buildHomeScreenModule() -> HomeScreenViewController? {
        guard let homeScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController else { return nil }
        // configure the VIPER module
        // View has strong reference of Presenter
        // Presenter has strong reference of Interactor, weak reference of View.
        // Interactor has strong reference of Router, weak reference of Presenter
        // Router has weak reference of View. Builder just builds the initial VIPER module.
        let presenter = HomeScreenPresenter(view: homeScreenVC)
        let router = HomeScreenRouter(viewController: homeScreenVC)
        let interactor = HomeScreenInteractor(router: router, presenter: presenter)
        homeScreenVC.presenter = presenter
        presenter.interactor = interactor
        return homeScreenVC
    }
}
