//
//  FeedCell.swift
//  PhotoSharingApp
//
//  Created by Harun Demirkaya on 28.12.2022.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var lblPostAuthor: UILabel!
    @IBOutlet weak var imgViewPostImage: UIImageView!
    @IBOutlet weak var lblPostDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
