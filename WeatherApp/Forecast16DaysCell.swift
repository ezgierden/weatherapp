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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
