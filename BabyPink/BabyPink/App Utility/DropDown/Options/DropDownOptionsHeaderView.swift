//
//  DropDownOptionsHeaderView.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

class DropDownOptionsHeaderView: UITableViewHeaderFooterView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewSetup()
    }
    public var headerTitle: String? {
        didSet {
            headerLabel.text = headerTitle
        }
    }
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    func viewSetup() {
        addSubview(headerLabel)
        headerLabel.anchors(centerX: centerXAnchor, centerY: centerYAnchor)
    }
}

