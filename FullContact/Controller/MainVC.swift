//
//  MainVC.swift
//  FullContact
//
//  Created by Iain Coleman on 24/11/2017.
//  Copyright © 2017 Fiendish Corporation. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var checkEmailBtn: UIButton!
    
    
    //Variables
    var textFieldIsEmpty = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkEmailBtn.isEnabled = false        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let DestViewController : ResultsVC = segue.destination as! ResultsVC
            let email = emailTxtField.text!
            DestViewController.toPass = email
    }
    
    
    @IBAction func editingChanged(_ sender: Any) {
        
        if emailTxtField.text == "" {
            checkEmailBtn.isEnabled = false
            textFieldIsEmpty = true
        } else {
            checkEmailBtn.isEnabled = true
            textFieldIsEmpty = false
        }
        
    }
    
    
    @IBAction func checkEmailBtnPressed(_ sender: Any) {
        
        if textFieldIsEmpty == false {
            performSegue(withIdentifier: "toResults", sender: nil)
            
        }
    }
    
    
}

