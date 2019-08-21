//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var highestTempOfTheDayLabel: UILabel!
    @IBOutlet weak var lowestTempOfTheDayLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingImageView: UIImageView!
    
    
    
    var viewModel = HomeViewModel(apiClient: WeatherAPIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.getForecast(location:"51.509865,-0.118092")
    }
    
    private func bindViewModel(){
        viewModel.hourlyList.bind(to: self) {strongSelf, hourlyList in
            strongSelf.collectionView?.reloadData()
        }
        viewModel.maxTemp.bind(to: self) { strongSelf, maxTemp in
            strongSelf.highestTempOfTheDayLabel.text = maxTemp
        }
        viewModel.minTemp.bind(to: self) { strongSelf, minTemp in
            strongSelf.lowestTempOfTheDayLabel.text = minTemp
        }
        viewModel.summary.bind(to: self) { strongSelf, summary in
            strongSelf.summaryLabel.text = summary
        }
        viewModel.temperature.bind(to: self) { strongSelf, temperature in
            strongSelf.degreeLabel.text = temperature
        }
        viewModel.humidity.bind(to: self) { strongSelf, humidity in
            strongSelf.humidityLabel.text = humidity
        }
        viewModel.windSpeed.bind(to: self) { strongSelf, windSpeed in
            strongSelf.windSpeedLabel.text = windSpeed
        }
        viewModel.cloudCover.bind(to: self) { strongSelf, cloudCover in
            strongSelf.cloudCoverLabel.text = cloudCover
        }
        viewModel.visibility.bind(to: self) { strongSelf, visibility in
            strongSelf.visibilityLabel.text = visibility
        }
        
        //  viewModel.forecastResponse.bind(to: self) { strongSelf, response in
        //    strongSelf.collectionView?.reloadData()
        
        // guard let response = response else {return} bind oldugu yerde in'den sonraki ilk satir
        
        
        /*   strongSelf.locationLabel.text = strongSelf.viewModel.getLocation()
         strongSelf.summaryLabel.text = response?.currentWeather.summary
         strongSelf.degreeLabel.text = response?.currentWeather.getFormattedTemp()
         
         strongSelf.dateAndTimeLabel.text = strongSelf.viewModel.formatDate(date: (response?.dailyWeather.data[0].getFormattedTimeStamp())!)
         strongSelf.highestTempOfTheDayLabel.text = response?.dailyWeather.data[0].getFormattedMaxTemp()
         strongSelf.lowestTempOfTheDayLabel.text = response?.dailyWeather.data[0].getFormattedMinTemp()
         
         strongSelf.humidityLabel.text = strongSelf.viewModel.formatDoubleToString(double: (response?.currentWeather.humidity)!)
         strongSelf.windSpeedLabel.text = strongSelf.viewModel.formatDoubleToString(double: (response?.currentWeather.windSpeed)!)
         strongSelf.cloudCoverLabel.text = strongSelf.viewModel.formatDoubleToString(double: (response?.currentWeather.cloudCover)!)
         strongSelf.visibilityLabel.text = strongSelf.viewModel.formatDoubleToString(double: (response?.currentWeather.visibility)!)
         
         strongSelf.backgroundImageView.image = UIImage(named: strongSelf.viewModel.formatBackgroundImageName(iconName: (response?.currentWeather.icon)!) )*/
        
        
        viewModel.isLoading.bind(to: self) { strongSelf, isLoading in
            if isLoading == false {
                strongSelf.loadingImageView.isHidden = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getHourlyCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForHoursOfTheDayCollectionViewCell", for: indexPath) as! WeatherForHoursOfTheDayCollectionViewCell
        
        let weatherAtIndex = viewModel.getWeatherAtIndex(index: indexPath.row)
        
        cell.degreeCellLabel.text = String(weatherAtIndex.getFormattedTemperature()) + "°"
        
        let time = viewModel.formatDateToHour(date: weatherAtIndex.getFormattedTime())
        cell.timeCellLabel.text = time
        
        cell.iconCellImageView.image = UIImage(named: weatherAtIndex.icon)
        
        return cell
    }
}

