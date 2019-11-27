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
import NVActivityIndicatorView

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    var pageNumber:Int = 1
    var memeData = [memeDataFormat]()       //Array That Stores the Data fetched from the REST API
    var selectedMeme:Int = 0
    var indicatorView:NVActivityIndicatorView?
    var bottomIndicatorView:NVActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 90
        getDataFromAPI(pageNumber)
        addTitle()
        indicatorView = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2 - 15, y: self.view.frame.height/2 - 15 - (self.navigationController?.navigationBar.frame.height)! , width: 30, height: 30), type: NVActivityIndicatorType.ballPulseSync, color: UIColor.systemTeal, padding: 3)
        bottomIndicatorView = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2 - 15, y: self.view.frame.height - 45 - (self.navigationController?.navigationBar.frame.height)! , width: 30, height: 30), type: NVActivityIndicatorType.ballPulseSync, color: UIColor.systemTeal, padding: 3)
        self.view.addSubview(indicatorView!)
        self.view.addSubview(bottomIndicatorView!)
        indicatorView?.startAnimating()
    }
    
    @IBAction func reloadBtnPressed(_ sender: Any) {
        self.indicatorView?.startAnimating()
        self.memeData.removeAll()
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
        pageNumber = 1
        getDataFromAPI(pageNumber)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMeme = indexPath.row
        performSegue(withIdentifier: "showSubmissions", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getDataFromAPI(_ pageNumber:Int){
        let APIURLString = "http://alpha-meme-maker.herokuapp.com/\(pageNumber)"
        if(pageNumber>1){
            bottomIndicatorView?.startAnimating()
        }
        URLSession.shared.dataTask(with: URL(string: APIURLString)!, completionHandler: {(data,response,error) in
            guard let data = data, error == nil else{
                self.showError(title: "Network Error", message: "Please check your connection and try again")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                self.showError(title: "Error", message: "There seems to have been an error. Please bear with us till we fix it and try again in sometime")
            }
            
            do{
                let jsonURLResponse = try JSONSerialization.jsonObject(with: data, options: [])
                let postResponse = jsonURLResponse as! [String:Any]
                let values = postResponse["data"] as! [[String:Any]]
                for val in values{
                    self.memeData.append(memeDataFormat(dict: val))
                }
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                    self.indicatorView?.stopAnimating()
                    self.bottomIndicatorView?.stopAnimating()
                }
            }
            catch let parsingError{
                print(parsingError)
            }
        }).resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SubmissionsViewController else{
            return
        }
        destinationVC.memeData = memeData[selectedMeme]
    }
    
    func showError(title:String, message:String){
        DispatchQueue.main.async {
            self.indicatorView?.stopAnimating()
            self.bottomIndicatorView?.stopAnimating()
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

