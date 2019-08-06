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

    var viewModel: HomeViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
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
        self.dateAndTimeLabel.text = self.viewModel.formatDate(date: self.viewModel.getCurrentDate())
        self.humidityLabel.text = self.viewModel.getHumidity()
        self.highestTempOfTheDayLabel.text = self.viewModel.getMaxTemp()
        self.lowestTempOfTheDayLabel.text = self.viewModel.getMinTemp()
        self.summaryLabel.text = self.viewModel.getSummary()
        self.degreeLabel.text = self.viewModel.getDegree()
        self.windSpeedLabel.text = self.viewModel.getWindSpeed()
        self.cloudCoverLabel.text = self.viewModel.getCloudCover()
        self.visibilityLabel.text = self.viewModel.getVisibility()
        self.backgroundImageView.image = UIImage(named: self.viewModel.getBackgroundImageName())
        
        self.collView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getHourlyCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForHoursOfTheDayCollectionViewCell", for: indexPath) as! WeatherForHoursOfTheDayCollectionViewCell
        
        let weatherAtIndex = self.viewModel.getWeatherAtIndex(index: indexPath.row)
        
        cell.degreeCellLabel.text = String(weatherAtIndex.temperature!)
        
        let time = viewModel.formatDateToHour(date: weatherAtIndex.time)
        cell.timeCellLabel.text = time
        
        cell.iconCellImageView.image = UIImage(named: weatherAtIndex.icon)
        
        return cell
    }
}

