//
//  TableViewCell.swift
//  DemoApp
//
//  Created by Prithvi Raj on 12/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(forecastData: ForecastWeather) {
        self.place.text = "\(forecastData.date)"
        self.temp.text = "\(Int(forecastData.temp))°"
        
    }

}
