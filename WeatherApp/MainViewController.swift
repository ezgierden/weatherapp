//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ezgi Erden on 05/07/2019.
//  Copyright © 2019 Ezgi Erden. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collView: UICollectionView!
    var weatherArray: [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Weather.forecast(withLocation: "42.3601,-71.0589") { (results:[Weather]) in
            self.weatherArray = results
            self.collView?.reloadData()
            //for result in results {
            //    print("\(result.temperatureMax)\n\n")
            //}
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForHoursOfTheDayCollectionViewCell", for: indexPath) as! WeatherForHoursOfTheDayCollectionViewCell
        
        cell.degreeCellLabel.text = String(weatherArray[indexPath.row].temperatureMax)
        return cell
    }


}

