//
//  LoadingTableViewCell.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 21/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
}
