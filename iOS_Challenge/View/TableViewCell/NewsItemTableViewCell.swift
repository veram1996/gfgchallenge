//
//  NewsItemTableViewCell.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import UIKit
import Kingfisher

class NewsItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newItemBackgroundView: UIView!

    func configCell(item: Items) {
        newItemBackgroundView.layer.cornerRadius = 10
        newsTitleLabel.text = item.title
        newsDateLabel.text =  item.pubDate
        guard let stringUrl = item.thumbnail, stringUrl != "" else { return }
        let url = URL(string: stringUrl)
        
        newsImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "imageplaceholder"),
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ]
        )
    }
}
