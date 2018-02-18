//
//  ProductCollectionCell.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
    
    public var model: Product? {
        didSet {
            updateUI()
        }
    }
    // add a NSCache for caching the images
    private let cacheImages = NSCache<NSString, UIImage>()
    
    // imageview
    private let imageVW: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // tag label
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        return label
    }()
    // description label
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    // price view
    private let priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // final price
    private let finalPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    // strike through price
    private let strikeThroughPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .red
        label.numberOfLines = 1
        label.isHidden = true
        return label
    }()
    // spinner
    private let activityIndiactor: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.color = Constants.pinkColor
        return spinner
    }()
    // favourite image
    private let favouriteImage: UIImageView =  {
        let imageVw = UIImageView()
        imageVw.translatesAutoresizingMaskIntoConstraints = false
        imageVw.image = UIImage()
        return imageVw
    }()
    
    // MARK:- update UI
    private func updateUI() {
        processTagLabel()
        processDescription()
        processImageUrl()
        processPricesLabel()
        favouriteImage.image = model?.isFavourite ?? false ? #imageLiteral(resourceName: "fillHeart") : UIImage()
    }
    // MARK:- Layout Setup
    private func layoutSetup() {
        addSubview(imageVW)
        addSubview(descriptionLabel)
        addSubview(priceView)
        addSubview(tagLabel)
        priceView.addSubview(strikeThroughPrice)
        priceView.addSubview(finalPrice)
        imageVW.addSubview(activityIndiactor)
        imageVW.addSubview(favouriteImage)
        
        // anchoring
        tagLabel.anchors(top: topAnchor, topConstants: 8.0, trailing: trailingAnchor, trailingConstants: -8)
        imageVW.anchors(top: topAnchor, topConstants: 16.0, leading: leadingAnchor, leadingConstants: 16.0, trailing: trailingAnchor, trailingConstants: -16.0)
        descriptionLabel.anchors(top: imageVW.bottomAnchor, topConstants: 0, leading: leadingAnchor, leadingConstants: 8,  trailing: trailingAnchor, trailingConstants: -8)
        priceView.anchors(top: descriptionLabel.bottomAnchor, topConstants: 0, leading: leadingAnchor, leadingConstants: 16, bottom: bottomAnchor, bottomConstants: 0, trailing: trailingAnchor, trailingConstants: -16, heightConstants: 22)
        finalPrice.anchors(centerX: priceView.centerXAnchor, centerY: priceView.centerYAnchor)
        strikeThroughPrice.anchors(trailing: finalPrice.leadingAnchor, trailingConstants: -16, centerY: priceView.centerYAnchor)
        activityIndiactor.anchors(centerX: imageVW.centerXAnchor, centerY: imageVW.centerYAnchor)
        favouriteImage.anchors(top: imageVW.topAnchor, leading: imageVW.leadingAnchor, heightConstants: 16, widthConstants: 16)
    }
    private func viewSetup() {
        layoutSetup()
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
    // view loading
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    // clean the collection view cell before reuse
    override func prepareForReuse() {
        tagLabel.text = ""
        descriptionLabel.text = ""
        imageVW.image = nil
        finalPrice.text = ""
        strikeThroughPrice.text = ""
        activityIndiactor.startAnimating()
    }
}

// MARK:-  Configure UI elements
extension ProductCollectionCell {
    
    private func processTagLabel() {
        guard let model = model else { return }
        if !model.productTag.isEmpty {
            tagLabel.text = " " + model.productTag
            setBackgroundOfTag(tag: model.productTag)
        } else {
            if let inventoryUsed = Int(model.inventoryUsed), let inventoryTotal = Int(model.inventoryTotal), inventoryTotal - inventoryUsed <= 5 {
                let tagValue = " Only \(inventoryTotal-inventoryUsed) Left "
                tagLabel.text = tagValue
                setBackgroundOfTag(tag: tagValue)
            }
        }
    }
    
    private func setBackgroundOfTag(tag: String) {
        guard !tag.isEmpty else { return }
        switch tag.lowercased() {
        case "new": tagLabel.backgroundColor = .blue
        case "sale": tagLabel.backgroundColor = .red
        default: tagLabel.backgroundColor = .brown
        }
    }
    
    private func processImageUrl() {
        guard let productId = model?.id else { return }
        let url = Constants.DataService.endPoint + "/assets/categories/\(productId).png"
        loadImage(urlString: url)
    }
    
    private func loadImage(urlString : String) {
        guard let url = URL(string: urlString), !urlString.isEmpty else { return }
        // check whether the image is present into cache or not
        if let image = cacheImages.object(forKey: NSString(string: urlString)) {
            imageVW.image = image
            activityIndiactor.stopAnimating()
        } else {
            let session = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data , error == nil else { return }
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    self?.cacheImages.setObject(image, forKey: NSString(string: urlString)) // setting into cache
                    self?.imageVW.image = image
                    self?.activityIndiactor.stopAnimating()
                }
            }
            session.resume()
        }
    }
    
    private func processPricesLabel() {
        guard let model = model else { return }
        if !model.skuFinalPrice.isEmpty {
            finalPrice.text = "$" + model.skuFinalPrice
        }
        if let value = Int(model.priceStrikeOff), !model.priceStrikeOff.isEmpty && value > 0 {
            let strikeThroughAmount = "$" + "\(value)"
            let attributedString = NSAttributedString(string: strikeThroughAmount, attributes: [NSAttributedStringKey.strikethroughStyle : 1])
            strikeThroughPrice.isHidden = false
            strikeThroughPrice.attributedText = attributedString
        }
    }
    
    private func processDescription() {
        guard let model = model else { return }
        let desc = model.productDescription
        let offer = model.productOffer
        let attributedString = NSMutableAttributedString()
        
        if !offer.isEmpty {
            let offerString = NSAttributedString(string: offer, attributes: [NSAttributedStringKey.foregroundColor : UIColor.red])
            attributedString.append(offerString)
        }
        
        if !desc.isEmpty {
            let descString = NSAttributedString(string: desc, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            attributedString.append(descString)
        }
        descriptionLabel.attributedText = attributedString
    }
}

// MARK:-  used for unit testing purpose (as everything in cell is private except model)
extension ProductCollectionCell {
    public func getTagLabelText() -> String? {
        return tagLabel.text
    }
    public func getDescriptionText() -> String? {
        return descriptionLabel.text
    }
    public func getPriceLabel() -> String? {
        return finalPrice.text
    }
    public func getStrikeThroughText() -> String? {
        return strikeThroughPrice.text
    }
}
