//
//  mainTableViewCell.swift
//  Memes For All
//
//  Created by Vandit Jain on 26/11/19.
//  Copyright © 2019 jainvandit. All rights reserved.
//

import UIKit
import TagListView

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeNameLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.memeImageView.layer.cornerRadius = self.memeImageView.frame.height/2
        self.memeImageView.contentMode = .scaleAspectFill
        self.memeImageView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
