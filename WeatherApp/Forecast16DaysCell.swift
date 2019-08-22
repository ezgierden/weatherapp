//
//  Forecast16DaysCell.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 29/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import UIKit

class Forecast16DaysCell: UITableViewCell {
    
    @IBOutlet weak var dateCellLabel: UILabel!
    @IBOutlet weak var maxTempCellLabel: UILabel!
    @IBOutlet weak var minTempCellLabel: UILabel!
    @IBOutlet weak var cellBackgroundImageView: UIImageView!
    @IBOutlet weak var cell: UITableViewCell!
    
    func setup(with weather: SixteenDaysWeather) {
        dateCellLabel.text = weather.dateAsString
        maxTempCellLabel.text = weather.formattedMaxTemp
        minTempCellLabel.text = weather.formattedMinTemp
        cellBackgroundImageView.image = UIImage(named: weather.weatherCode.codeAsString)
    }
}
