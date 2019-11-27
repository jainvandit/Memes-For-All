//
//  memeData.swift
//  Memes For All
//
//  Created by Vandit Jain on 26/11/19.
//  Copyright © 2019 jainvandit. All rights reserved.
//

import Foundation

struct memeDataFormat{
    var id:Int
    var bottomText:String
    var imageURLString:String
    var name:String
    var tags = [String]()
    var topText:String
    
    init(dict: [String:Any]){
        self.id = dict["ID"] as! Int
        self.bottomText = dict["bottomText"] as? String ?? ""
        self.imageURLString = dict["image"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        let tagsVar = dict["tags"] as? String ?? ""
        let tagsArr = tagsVar.components(separatedBy: ", ")
        self.tags.append(contentsOf: tagsArr)
        for i in 0...tags.count-1{
            tags[i] = "#\(tags[i])"
        }
        self.topText = dict["topText"] as? String ?? ""
    }
}
