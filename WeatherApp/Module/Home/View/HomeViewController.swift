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
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = HomeViewModel(apiClient: WeatherAPIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.getForecast(location:"42.3601,-71.0589")
    }
    
    private func bindViewModel(){
        viewModel.forecastResponse.bind(to: self) { strongSelf, response in
            strongSelf.collectionView?.reloadData()
            
            strongSelf.locationLabel.text = strongSelf.viewModel.getLocation()
            strongSelf.summaryLabel.text = response?.currentWeather.summary
            strongSelf.degreeLabel.text = response?.currentWeather.getFormattedTemp()
            
            strongSelf.dateAndTimeLabel.text = strongSelf.viewModel.formatDate(date: response?.dailyWeather.data[0].getFormattedTimeStamp())
            strongSelf.highestTempOfTheDayLabel.text = response?.dailyWeather.data[0].getFormattedMaxTemp()
            strongSelf.lowestTempOfTheDayLabel.text = response?.dailyWeather.data[0].getFormattedMinTemp()
            
            strongSelf.humidityLabel.text = strongSelf.viewModel.formatDoubleToString(double: (response?.currentWeather.humidity)!)
            strongSelf.windSpeedLabel.text = strongSelf.viewModel.formatDoubleToString(double: (response?.currentWeather.windSpeed)!)
            strongSelf.cloudCoverLabel.text = strongSelf.viewModel.formatDoubleToString(double: (response?.currentWeather.cloudCover)!)
            strongSelf.visibilityLabel.text = strongSelf.viewModel.formatDoubleToString(double: (response?.currentWeather.visibility)!)
            
            strongSelf.backgroundImageView.image = UIImage(named: strongSelf.viewModel.formatBackgroundImageName(iconName: (response?.currentWeather.icon)!) )
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
    
    /*private func setData() {
     dateAndTimeLabel.text = viewModel.formatDate(date: viewModel.getCurrentDate())
     humidityLabel.text = viewModel.getHumidity()
     highestTempOfTheDayLabel.text = viewModel.getMaxTemp() + "°"
     lowestTempOfTheDayLabel.text = viewModel.getMinTemp() + "°"
     summaryLabel.text = viewModel.getSummary()
     degreeLabel.text = viewModel.getDegree() + "°"
     windSpeedLabel.text = viewModel.getWindSpeed()
     cloudCoverLabel.text = viewModel.getCloudCover()
     visibilityLabel.text = viewModel.getVisibility()
     backgroundImageView.image = UIImage(named: viewModel.getBackgroundImageName())
     locationLabel.text = viewModel.getLocation()
     
     collectionView?.reloadData()
     }*/
    
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

