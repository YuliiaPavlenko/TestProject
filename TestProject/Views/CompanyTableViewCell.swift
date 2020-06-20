//
//  CompanyTableViewCell.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import Kingfisher

class CompanyTableViewCell: UITableViewCell {
    
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var companyImageView: UIImageView!
    
    override func prepareForReuse() {
      super.prepareForReuse()
      
      configure(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        companyNameLabel.textColor = .darkText
    }
    
    func configure(with company: Company?) {
      if let company = company {
        companyNameLabel?.text = company.name
        
        if let coverImage = company.coverImage {
            let fixedCoverImageName = coverImage.replacingOccurrences(of: "i.", with: "")
            let url = URL(string: fixedCoverImageName)
            companyImageView.kf.setImage(with: url)
        } else {
            companyImageView.image = UIImage(named: "noImageIcon.png")
        }
        
        companyNameLabel.alpha = 1
        companyImageView.alpha = 1
      } else {
        companyNameLabel.alpha = 0
        companyImageView.alpha = 0
      }
    }
}
