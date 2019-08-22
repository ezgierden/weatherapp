//
//  WeatherForHoursOfTheDayCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 09/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import UIKit

class WeatherForHoursOfTheDayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconCellImageView: UIImageView!
    @IBOutlet weak var timeCellLabel: UILabel!
    @IBOutlet weak var degreeCellLabel: UILabel!
    
    func setup(with weather: HourlyData){
        
        degreeCellLabel.text = weather.formattedTemperature
        timeCellLabel.text = weather.formattedTime
        iconCellImageView.image = UIImage(named: weather.icon)
    }
}
