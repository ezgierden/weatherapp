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
    
    var sixteenDaysViewModel:SixteenDaysViewModelProtocol = SixteenDaysViewModel(apiClient: WeatherAPIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sixteenDaysViewModel.getForecast(latitude:"42.3601", longitude:"-71.0589") {
            
            DispatchQueue.main.async {
                self.setData()
            }
        }
    }
    
    private func setData() {
        self.forecast16DaysTableView?.reloadData()
        self.locationLabel.text = self.sixteenDaysViewModel.getLocation()
    }
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    // MARK: - Table view data source
    
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
        
        cell.dateCellLabel.text = sixteenDaysViewModel.formatDate(timeStamp: weatherAtIndex.timeStamp)
        cell.maxTempCellLabel.text = weatherAtIndex.getFormattedMaxTemp() + "°"
        cell.minTempCellLabel.text = String(Int(weatherAtIndex.minTemp)) + "°"
        cell.cellBackgroundImageView.image = UIImage(named: String(weatherAtIndex.weatherCode.code))
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

