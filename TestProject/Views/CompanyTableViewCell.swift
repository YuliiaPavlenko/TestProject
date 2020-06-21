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
        configureUI()
    }
    
    private func configureUI() {
        companyNameLabel.textColor = Colors.grayTitle
        companyNameLabel.font = Fonts.title
        
        companyImageView.layer.cornerRadius = 7.0
        companyImageView.clipsToBounds = true
    }
    
    func configure(with company: Company?) {
        if let company = company {
            companyNameLabel?.text = company.name
            
            if let coverImage = company.coverImage {
                // fixed url from api
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
