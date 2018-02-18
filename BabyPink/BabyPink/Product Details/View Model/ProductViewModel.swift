//
//  ProductViewModel.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

class ProductViewModel {
    
    // add a NSCache for caching the images
    private let cacheImages = NSCache<NSString, UIImage>()
    weak var controller: ProductDetailsViewController? // weak ref of view controller
    
    func updateImage(id: String) {
        guard !id.isEmpty else { return }
        let url = Constants.DataService.endPoint + "/assets/categories/\(id).png"
        fetchImage(urlString: url) { (image) in
            DispatchQueue.main.async { [weak self] in
                if let image = image {
                    self?.controller?.imageVw.image = image
                    self?.controller?.activityIndiactor.stopAnimating()
                }
            }
        }
    }
   
    func addPulseAnimation(layer: CALayer) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 1.0
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(animation, forKey: "Pulse it")
    }
    
    func addCartTapped() {
        let existingCount = UserDefaults.standard.value(forKey: Constants.Cart.cartKey) as? Int ?? 0
        // add the stepper count value
        let stepperCount = Int(controller?.stepperOutlet.value ?? 0)
        let total = existingCount + stepperCount
        controller?.topView.model = TopViewModel(leftImageType: .back, title: "Product Details", cartNumber: "\(total)")
        UserDefaults.standard.set(total, forKey: Constants.Cart.cartKey)
    }
    
    func favouriteTapped() {
        guard let product = controller?.model, let index = controller?.index, let favouriteImageVw = controller?.favouriteImageVw else { return }
        let isFavourite = product.isFavourite
        controller?.model?.isFavourite = !isFavourite // update model
        controller?.delegate?.favouriteSelected(selection: !isFavourite, index: index)
        controller?.favouriteImageVw.image = controller?.model?.isFavourite ?? false ? #imageLiteral(resourceName: "fillHeart") : #imageLiteral(resourceName: "heart")
        UIView.transition(with: favouriteImageVw, duration: 1.0, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.controller?.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func showOfferAvailMessage(x: Int, product: Product) {
        guard let controller = controller else { return }
        let offerString = "Add \(product.buy - x) items to avail \(product.free) item FREE"
        controller.offerLabel.text = offerString
        if x == 1 {
            UIView.transition(with: controller.offerLabel, duration: 1.0, options: .transitionFlipFromRight, animations: { [weak self] in
                self?.controller?.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func showCongratsMessage(x: Int, product: Product) {
        guard let controller = controller else { return }
        let offerString = "Congratulations !!! You avail \(product.free) FREE item"
        controller.offerLabel.text = offerString
        if x == product.buy {
            UIView.transition(with: controller.offerLabel, duration: 1.0, options: .transitionFlipFromLeft, animations: { [weak self] in
                self?.controller?.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
}

// MARK:- Private extension
private extension ProductViewModel {
    
    func fetchImage(urlString : String, completionHandler: @escaping ((UIImage?)->()) ) {
        guard let url = URL(string: urlString), !urlString.isEmpty else { return }
        // check whether the image is present into cache or not
        if let image = cacheImages.object(forKey: NSString(string: urlString)) {
            completionHandler(image)
        } else {
            let session = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data , error == nil else { return }
                guard let image = UIImage(data: data) else { return }
                self?.cacheImages.setObject(image, forKey: NSString(string: urlString)) // setting into cache
                completionHandler(image)
                
            }
            session.resume()
        }
    }
}
