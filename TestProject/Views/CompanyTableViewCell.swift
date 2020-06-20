//
//  CompanyTableViewCell.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var companyImageView: UIImageView!
    
    override func prepareForReuse() {
      super.prepareForReuse()
      
      configure(with: .none)
    }
    
    override func awakeFromNib() {
      super.awakeFromNib()
      
      companyImageView.layer.cornerRadius = 6
        companyNameLabel.textColor = .lightText
      
    }
    
    func configure(with company: Company?) {
      if let company = company {
        companyNameLabel?.text = company.name
        companyImageView?.image = UIImage(named: company.coverImage ?? "noImageIcon")
        
        companyNameLabel.alpha = 1
        companyImageView.alpha = 1
      } else {
        companyNameLabel.alpha = 0
        companyImageView.alpha = 0
      }
    }
}
