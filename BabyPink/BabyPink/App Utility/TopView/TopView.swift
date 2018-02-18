//
//  TopView.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

struct TopViewModel {
    let leftImageType: LeftImageType
    let title: String
    let cartNumber: String
}
enum LeftImageType {
    case menu
    case back
}
protocol TopViewProtocol: class {
    func leftImageTapped(type: LeftImageType)
}
/*
     TopView : It is a reusable View, used in Home page and product details page.
*/
class TopView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutSetup()
    }
    var model: TopViewModel? {
        didSet {
            updateUI()
        }
    }
    weak var delegate: TopViewProtocol?
    private var leftImageType: LeftImageType = .menu {
        didSet {
            switch leftImageType {
            case .menu: leftImage.image = #imageLiteral(resourceName: "hamburger")
            case .back: leftImage.image = #imageLiteral(resourceName: "back")
            }
        }
    }
    // left image
    private let leftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    // title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    // rightImage
    private let rightCartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "cart")
        return imageView
    }()
    // cart label
    private let cartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .red
        return label
    }()
    // seperator view
    private let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        return view
    }()
    // update UI
    private func updateUI() {
        leftImageType = model?.leftImageType ?? .menu
        titleLabel.text = model?.title ?? ""
        if let cartNumber = model?.cartNumber {
            cartLabel.text =  " " + cartNumber + " "
            cartLabel.layer.cornerRadius = 5.0
            cartLabel.layer.masksToBounds = true
        }
        leftImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftImageTapped)))
    }
    // layout configure
    private func layoutSetup() {
        addSubview(leftImage)
        addSubview(titleLabel)
        addSubview(rightCartImage)
        addSubview(cartLabel)
        addSubview(seperatorView)
        
        leftImage.anchors(leading: leadingAnchor, leadingConstants: 16, heightConstants: 32, widthConstants: 32, centerY: centerYAnchor, centerYConstants: 5)
        titleLabel.anchors(centerX: centerXAnchor, centerY: centerYAnchor, centerYConstants: 5)
        rightCartImage.anchors(trailing: trailingAnchor, trailingConstants: -16, heightConstants: 32, widthConstants: 32, centerY: centerYAnchor, centerYConstants: 5)
        cartLabel.anchors(trailing: trailingAnchor, trailingConstants: -10, centerY: centerYAnchor, centerYConstants: -5)
        seperatorView.anchors(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, heightConstants: 1)
    }
    @objc func leftImageTapped() {
        delegate?.leftImageTapped(type: leftImageType)
    }
}
