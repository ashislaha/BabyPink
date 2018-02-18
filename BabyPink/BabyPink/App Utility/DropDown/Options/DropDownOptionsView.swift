//
//  DropDownOptionsView.swift
//  BabyPink
//
//  Created by Ashis Laha on 28/01/18
//  Copyright © 2018 Ashis Laha. All rights reserved.
//

import UIKit

/*
     DropDownOptionsView is a reusable UI component showing the drop-down options in table view.
*/

protocol DropDownProtocol: class {
    func select(name: String, indexPath: IndexPath)
}

class DropDownOptionsView: UIView {
    
    public var model: [String] = []
    public var headerTitle: String = "Choose"
    weak var delegate: DropDownProtocol?
    private var tableView: UITableView!
    
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewSetUp()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableViewSetUp()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK:- table view setup
    private func tableViewSetUp() {
        tableView = UITableView(frame: bounds)
        addSubview(tableView)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        // register cells
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.DropDown.dropDownCell)
        tableView.register(DropDownOptionsHeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.DropDown.dropDownHeader)
        // resize based on content
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        // scroll Indicator insets
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.reloadData()
    }
}
