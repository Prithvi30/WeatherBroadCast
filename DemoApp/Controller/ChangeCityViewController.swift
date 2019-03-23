//
//  ChangeCityViewController.swift
//  DemoApp
//
//  Created by Prithvi Raj on 12/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city : String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.cornerRadius = 5
        }
    }
    
    
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredANewCityName(city: cityName)
        
        self.navigationController?.popViewController(animated: true)
        
    }
  
}
