//
//  SubmissionsViewController.swift
//  Memes For All
//
//  Created by Vandit Jain on 26/11/19.
//  Copyright © 2019 jainvandit. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SubmissionsViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var memeData:memeDataFormat?
    var indicatorView:NVActivityIndicatorView?
    struct submissionData{
        var topText:String
        var bottomText:String
        var date:String
        init(dict:[String:Any]){
            self.topText = dict["topText"] as? String ?? ""
            self.bottomText = dict["bottomText"] as? String ?? ""
            self.date = dict["dateCreated"] as? String ?? ""
        }
    }
    var submissions = [submissionData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        getSubmissions() //Get the submissions data for the particular meme
        indicatorView = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2 - 15, y: self.view.frame.height/2 - 15 - (self.navigationController?.navigationBar.frame.height)! , width: 30, height: 30), type: NVActivityIndicatorType.ballPulseSync, color: UIColor.white, padding: 3)
        self.view.addSubview(indicatorView!)
        indicatorView?.startAnimating()
    }

    ///Function to get submission data from API
    func getSubmissions(){
        guard let memeData = memeData else{
            return
        }
        let APIURLString = "http://alpha-meme-maker.herokuapp.com/memes/\(memeData.id)/submissions/"
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
                    self.submissions.append(submissionData(dict: val))
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.indicatorView?.stopAnimating()
                    if(self.submissions.count == 0){
                        self.view.addSubview(self.noDataLabel())
                        
                    }
                }
            }
            catch let parsingError{
                print(parsingError)
            }
        }).resume()
    }
    ///Function to set up label in case no submissions are found
    func noDataLabel() -> UILabel{
        let label = UILabel(frame: CGRect(x: 0, y: self.view.frame.height/2 - 15, width: self.view.frame.width , height: 30))
        label.text = ":( No Submissions Yet"
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return submissions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? submissionsCollectionViewCell else{
            return UICollectionViewCell()
        }
        guard let memeData = self.memeData else{
            return UICollectionViewCell()
        }
        cell.memeImage.kf.setImage(with: URL(string: memeData.imageURLString)!)
        cell.topText.attributedText = NSAttributedString(string: submissions[indexPath.row].topText, attributes: [NSAttributedString.Key.strokeColor: UIColor.black, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.strokeWidth: -3.0, NSAttributedString.Key.font: UIFont(name: "impact", size: 20)!])
        cell.bottomText.attributedText = NSAttributedString(string: submissions[indexPath.row].bottomText, attributes: [NSAttributedString.Key.strokeColor: UIColor.black, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.strokeWidth: -3.0, NSAttributedString.Key.font: UIFont(name: "impact", size: 20)!])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - 32
        return CGSize(width: collectionViewSize/2, height: (collectionViewSize + 90)/2)
    }
    
    ///Function to show error when api fails to load data
    func showError(title:String, message:String){
        DispatchQueue.main.async {
            self.indicatorView?.stopAnimating()
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
