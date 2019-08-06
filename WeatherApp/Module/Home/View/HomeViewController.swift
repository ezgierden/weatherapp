//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var highestTempOfTheDayLabel: UILabel!
    @IBOutlet weak var lowestTempOfTheDayLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var collView: UICollectionView!
    
    var dailyWeatherArray: [Weather] = []
    var hourlyWeatherArray: [Weather] = []
    var viewModel: HomeViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let collectionViewFirstline = UIView(frame: CGRect(x: 10, y: 520, width: 400, height: 1.0))
        collectionViewFirstline.layer.borderWidth = 1.0
        collectionViewFirstline.layer.borderColor = UIColor.white.cgColor
        self.view.addSubview(collectionViewFirstline)
        
        let collectionViewSecondLine = UIView(frame: CGRect(x: 10, y: 650, width: 400, height: 1.0))
        collectionViewSecondLine.layer.borderWidth = 1.0
        collectionViewSecondLine.layer.borderColor = UIColor.white.cgColor
        self.view.addSubview(collectionViewSecondLine)
        
        let bottomLine = UIView(frame: CGRect(x: 10, y: 780, width: 400, height: 1.0))
        bottomLine.layer.borderWidth = 1.0
        bottomLine.layer.borderColor = UIColor.white.cgColor
        self.view.addSubview(bottomLine)
        
        
        viewModel.getForecast(location: "42.3601,-71.0589") {
             let humidity = self.viewModel.getHumidity()
             self.humidityLabel.text = humidity
        }

        
        
      /*  Weather.forecast(withLocation: "42.3601,-71.0589") { (darkSkyApiResponse:DarkSkyApiResponse) in
            
            self.dailyWeatherArray = darkSkyApiResponse.dailyList
            self.hourlyWeatherArray = Array(darkSkyApiResponse.hourlyList[0...23])
            let currentWeather = darkSkyApiResponse.currentWeather
            
            DispatchQueue.main.async {
                
                self.locationLabel.text = "Boston, MA"
                self.highestTempOfTheDayLabel.text = String(Int(darkSkyApiResponse.dailyList[0].temperatureMax!))
                self.lowestTempOfTheDayLabel.text = String(Int(darkSkyApiResponse.dailyList[0].temperatureMin!))
                self.summaryLabel.text = currentWeather.summary
                self.degreeLabel.text = String(Int(currentWeather.temperature)) + "°"
                self.humidityLabel.text = String(currentWeather.humidity)
                self.windSpeedLabel.text = String(currentWeather.windSpeed)
                self.cloudCoverLabel.text = String(currentWeather.cloudCover)
                self.visibilityLabel.text = String(currentWeather.visibility)
                self.backgroundImageView.image = UIImage(named: (currentWeather.icon) + "BG")
                
                let currentDate = self.viewModel.formatDate(date: darkSkyApiResponse.dailyList[0].time)
                self.dateAndTimeLabel.text = currentDate
                
                self.collView?.reloadData()
            }
        }*/
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForHoursOfTheDayCollectionViewCell", for: indexPath) as! WeatherForHoursOfTheDayCollectionViewCell
        
        cell.degreeCellLabel.text = String(hourlyWeatherArray[indexPath.row].temperature!)
        
        let time = viewModel.formatDateToHour(date: hourlyWeatherArray[indexPath.row].time)
        cell.timeCellLabel.text = time
        
        cell.iconCellImageView.image = UIImage(named: hourlyWeatherArray[indexPath.row].icon)
        
        return cell
    }
}

