//
//  DropDownUI.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

/*
    DropDownUI is a reusable view used in Country Page and Home Page for showing the drop-down view.
*/

class DropDownUI: UIView {
    public var labelInfo: String? {
        didSet {
            // update label
            infoLabel.text = labelInfo
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutSetup()
    }
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    private let imageVw: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "drop_down")
        return imageView
    }()
    private func layoutSetup() {
        addSubview(infoLabel)
        addSubview(imageVw)
        infoLabel.anchors(leading: leadingAnchor, leadingConstants: 33, centerY: centerYAnchor)
        imageVw.anchors(leading: infoLabel.trailingAnchor, leadingConstants: 18, trailing: trailingAnchor, trailingConstants: -16, heightConstants: 16, widthConstants: 22, centerY: centerYAnchor)
        
        // view setup
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
    }
}
