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

    var viewModel: HomeViewModelProtocol = HomeViewModel(apiClient: WeatherAPIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setupUI()
        
        viewModel.getForecast(location: "42.3601,-71.0589") {
            
            DispatchQueue.main.async {
                self.setData()
            }
        }
    }
    
    private func setupUI() {
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
    }
    
    private func setData() {
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

