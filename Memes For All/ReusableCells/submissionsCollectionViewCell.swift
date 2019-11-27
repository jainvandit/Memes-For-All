//
//  submissionsCollectionViewCell.swift
//  Memes For All
//
//  Created by Vandit Jain on 26/11/19.
//  Copyright © 2019 jainvandit. All rights reserved.
//

import UIKit

class submissionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var memeImage: UIImageView!
    
    let topText = UILabel()
    let bottomText = UILabel()
//    let dateText = UILabel()
    override func awakeFromNib() {
        memeImage.translatesAutoresizingMaskIntoConstraints = false
        memeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2.5).isActive = true
        memeImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2.5).isActive = true
        memeImage.widthAnchor.constraint(equalToConstant: (UIApplication.shared.windows[0].frame.width - 36) / 2).isActive = true
        memeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.5).isActive = true
        memeImage.heightAnchor.constraint(equalToConstant: (UIApplication.shared.windows[0].frame.width + 30) / 2).isActive = true
        
        createTopAndBottomText()
    }
    
    func createTopAndBottomText(){
        topText.translatesAutoresizingMaskIntoConstraints = false
        bottomText.translatesAutoresizingMaskIntoConstraints = false
        //dateText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topText)
        self.addSubview(bottomText)
        //self.addSubview(dateText)
        
        topText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        topText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        topText.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        topText.textAlignment = .center
        topText.numberOfLines = 3
        
        bottomText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        bottomText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        bottomText.bottomAnchor.constraint(equalTo: self.memeImage.bottomAnchor, constant: -5).isActive = true
        bottomText.textAlignment = .center
        bottomText.numberOfLines = 3
        
//        dateText.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        dateText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
//        dateText.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        dateText.font = UIFont.systemFont(ofSize: 8)
//        dateText.textColor = UIColor.gray
//        dateText.textAlignment = .right
        
    }
}
