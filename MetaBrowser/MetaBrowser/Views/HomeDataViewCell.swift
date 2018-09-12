//
//  HomeDataViewCell.swift
//  MetaBrowser
//
//  Created by Николай Садчиков on 10.09.2018.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import MapleBacon

class HomeDataViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 5
        iconImageView.layer.cornerRadius = 10
    }

    func configure(with model: HomeItem) {
        nameLabel.text = model.name
        companyLabel.text = model.company
        descriptionLabel.text = model.description
        
        var urlString = model.iconUrl ?? ""
        if urlString.range(of: "=s180-rw") != nil {
            urlString = urlString.replacingOccurrences(of: "=s180-rw", with: "")
        }
        let url = URL(string: urlString)
        iconImageView.setImage(with: url, placeholder: R.image.emptyImageCell(), transformer: nil, progress: nil, completion: nil)
    }
}
