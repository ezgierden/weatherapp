//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var highestTempOfTheDayLabel: UILabel!
    @IBOutlet weak var lowestTempOfTheDayLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    @IBOutlet weak var collView: UICollectionView!
    
    var dailyWeatherArray: [Weather] = []
    var hourlyWeatherArray: [Weather] = []
    var currentWeatherArray: [String:Any] = [:]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Weather.forecast(withLocation: "42.3601,-71.0589") { (darkSkyApiResponse:DarkSkyApiResponse) in
            
            self.dailyWeatherArray = darkSkyApiResponse.dailyList
            self.hourlyWeatherArray = Array(darkSkyApiResponse.hourlyList[0...23])
            self.currentWeatherArray = darkSkyApiResponse.currentList
            
            DispatchQueue.main.async {
                self.highestTempOfTheDayLabel.text = String(darkSkyApiResponse.dailyList[0].temperatureMax!)
                self.lowestTempOfTheDayLabel.text = String(darkSkyApiResponse.dailyList[0].temperatureMin!)
                self.summaryLabel.text = darkSkyApiResponse.currentList["summary"] as! String
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.dateFormat = "MMMM, dd"
                let currentDate = dateFormatter.string(from: darkSkyApiResponse.dailyList[0].time)
                self.dateAndTimeLabel.text = currentDate
                
                self.collView?.reloadData()
            }
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForHoursOfTheDayCollectionViewCell", for: indexPath) as! WeatherForHoursOfTheDayCollectionViewCell
        
        cell.degreeCellLabel.text = String(hourlyWeatherArray[indexPath.row].temperature!)
        
        let hourlyFormatter = DateFormatter()
        hourlyFormatter.timeZone = TimeZone(abbreviation: "GMT")
        hourlyFormatter.dateFormat = "HH"
        let time = hourlyFormatter.string(from: hourlyWeatherArray[indexPath.row].time)
        
        cell.timeCellLabel.text = time
        
        cell.iconCellImageView.image = UIImage(named: hourlyWeatherArray[indexPath.row].icon)
        
        return cell
    }


}

