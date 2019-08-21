//
//  Forecast16DaysTableViewController.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 29/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import UIKit

class Forecast16DaysTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var forecast16DaysTableView: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var sixteenDaysViewModel = SixteenDaysViewModel(apiClient: WeatherAPIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        sixteenDaysViewModel.getForecast(latitude:"42.3601", longitude:"-71.0589")
    }
    
    private func bindViewModel(){
        sixteenDaysViewModel.weatherList.bind(to: self) { strongSelf, weatherList in
            strongSelf.forecast16DaysTableView?.reloadData()
        }
        sixteenDaysViewModel.location.bind(to: self) { strongSelf, location in
            strongSelf.locationLabel.text = location
        }
        sixteenDaysViewModel.isLoading.bind(to: self) { strongSelf, isLoading in
            if isLoading == true {
                strongSelf.activityIndicator.startAnimating()
            } else {
                strongSelf.activityIndicator.stopAnimating()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sixteenDaysViewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Forecast16DaysCell", for: indexPath) as! Forecast16DaysCell
        
        let weatherAtIndex = self.sixteenDaysViewModel.getWeatherAtIndex(index: indexPath.row)
        cell.setup(with: weatherAtIndex)
        
        return cell
    }
}

