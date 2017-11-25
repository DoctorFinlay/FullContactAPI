//
//  ResultsVC.swift
//  FullContact
//
//  Created by Iain Coleman on 24/11/2017.
//  Copyright © 2017 Fiendish Corporation. All rights reserved.
//

import UIKit
import Kingfisher

class ResultsVC: UIViewController {

    //Outlets
    @IBOutlet weak var personNameLbl: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personTextField: UITextView!
    
    
    //Variables
    var toPass = String()
    var textFieldContentString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(serverReturnedError), name: NOTIF_SERVER_ERROR, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(serverCode200Received), name: NOTIF_SERVER_SUCCESS, object: nil)
        
        let api = APIDataService.instance
        
        //Perform search
        print("Email being searched is \(toPass)")
        api.getPersonData(email: toPass) { (success) in
            if success {
                //Set name label and image
                
                if api.personName == "" {
                    self.personNameLbl.text = "Not found!"
                } else {
                    self.personNameLbl.text = api.personName
                }
                
                //Append gender and location to text field if they are given
                if api.personGender == "" {
                    self.textFieldContentString = "Gender: Not found\n"
                } else {
                    self.textFieldContentString = "Gender: \(api.personGender)\n"
                }
                if api.personLocation == "" {
                    self.textFieldContentString += "Location: Not found\n"
                } else {
                    self.textFieldContentString += "Location: \(api.personLocation)\n"
                }
                
                if api.personImageUrls.count > 0 {
                    let imageUrl = URL(string: api.personImageUrls[0])
                    self.personImage.kf.setImage(with: imageUrl)
                } else {
                    self.personImage.image = UIImage(named: "anon")
                }
                
//                if api.personSocialNetworkUrl.count > 0 {
//                    print("\(api.personSocialNetworkUrl.count) social urls found")
//
//                    for index in 0...(api.personSocialNetworkUrl.count - 1) {
//                        print("Social url: \(api.personSocialNetworkUrl[index])")
//                    }
//                }
                
                //Iterate through the Social Networking arrays to get the names and urls and append them to the text field
                if api.personSocialNetworkName.count > 0 {
                    self.textFieldContentString += "Social Network Profile(s) found:\n"

                    for index in 0...(api.personSocialNetworkName.count - 1) {
                        self.textFieldContentString += "\(api.personSocialNetworkName[index]) \(api.personSocialNetworkUrl[index])\n"
                    }
                }

                //Iterate through Digital Footprint array to get any information
                if api.personDigitalFootprint.count > 0 {
                    self.textFieldContentString += "Digital Footprint data found:\n"
                    for index in 0...(api.personDigitalFootprint.count - 1) {
                        self.textFieldContentString += "\(index))\(api.personDigitalFootprint[index])"
                    }
                }

                // Place string into text field
                print(api.personName)
                print(self.textFieldContentString)
                self.personTextField.text = self.textFieldContentString
            } else {
                self.personNameLbl.text = "Not found!"
                self.personTextField.text = "No data found"
            }
        }
    }
    
    
    
        @objc func serverReturnedError() {
            //Dialog box alerts user that server returned error
            let alert = UIAlertController(title: "Server Error", message: "The server is not responding. Please try again later", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .destructive) { (action) -> Void in
    
            }
            alert.addAction(okButton)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    
    
        @objc func serverCode200Received() {
    
        }

    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
