//
//  ViewController.swift
//  Memes For All
//
//  Created by Vandit Jain on 26/11/19.
//  Copyright © 2019 jainvandit. All rights reserved.
//

import UIKit
import Kingfisher
import TagListView

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
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
            let tagsArr = tagsVar.components(separatedBy: ",")
            self.tags.append(contentsOf: tagsArr)
            self.topText = dict["topText"] as? String ?? ""
        }
    }
    var pageNumber:Int = 1
    var memeData = [memeDataFormat]()       //Array That Stores the Data fetched from the REST API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 90
        getDataFromAPI(pageNumber)
        addTitle()
    }
    
    func addTitle(){
        let label = UILabel()
        label.text = "Memestagram"
        label.textAlignment = .left
        label.font = UIFont(name: "Billabong", size: 30)!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    ///Returns number of cells in the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeData.count
    }
    
    ///Returns the cell for the particular row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "mainTableViewCell") as? mainTableViewCell else {
            return UITableViewCell()
        }
        cell.memeNameLabel.text = memeData[indexPath.row].name
        cell.memeImageView.kf.setImage(with: URL(string: self.memeData[indexPath.row].imageURLString)!)
        cell.tagListView.removeAllTags()
        cell.tagListView.addTags(memeData[indexPath.row].tags)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if(bottomEdge >= scrollView.contentSize.height){
            self.pageNumber+=1
            getDataFromAPI(self.pageNumber)
        }
    }
    
    func getDataFromAPI(_ pageNumber:Int){
        let APIURLString = "http://alpha-meme-maker.herokuapp.com/\(pageNumber)"
        
        URLSession.shared.dataTask(with: URL(string: APIURLString)!, completionHandler: {(data,response,error) in
            guard let data = data else{
                return
            }
            
            do{
                let jsonURLResponse = try JSONSerialization.jsonObject(with: data, options: [])
                let postResponse = jsonURLResponse as! [String:Any]
                let values = postResponse["data"] as! [[String:Any]]
                for val in values{
                    self.memeData.append(ViewController.self.memeDataFormat(dict: val))
                }
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
            catch let parsingError{
                print(parsingError)
            }
        }).resume()
    }

}

