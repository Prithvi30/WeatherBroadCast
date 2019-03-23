//
//  DetailsViewController.swift
//  DemoApp
//
//  Created by Prithvi Raj on 13/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var wSpeedLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text =  UserDefaults.standard.string(forKey: "Key")
        humidityLabel.text =  UserDefaults.standard.string(forKey: "hum")
        pressureLabel.text = UserDefaults.standard.string(forKey: "Pre")
        visibilityLabel.text = UserDefaults.standard.string(forKey: "Visi")
        wSpeedLabel.text = UserDefaults.standard.string(forKey: "Speed")
        descLabel.text = UserDefaults.standard.string(forKey: "des")
        cloudsLabel.text = UserDefaults.standard.string(forKey: "all")

        
    }
    

    @IBAction func goBack(_ sender: Any) {
        
        
 self.navigationController?.popToRootViewController(animated: true)
      

        
        
    }
    

}
