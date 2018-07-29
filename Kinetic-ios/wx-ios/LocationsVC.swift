//
//  LocationsVC.swift
//  wx-ios
//
//  Created by Fang on 7/28/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

class LocationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let names = ["Palo Alto", "Stanford", "Mountain View", "Atherton", "Sunnyvale", "Redwood City"]
    let addresses = ["81 San Antonio Rd, Palo Alto", "360 Oak Rd, Stanford", "1415a W.El Camino Real, Mountain View", "2821 El Camino Real, Redwood City", "680 West El Camino Real, Sunnyvale", "345 El Camino Real, Redwood City"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        self.navigationItem.title = "Nearby Locations"
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LocationsTableViewCell", for: indexPath)
        let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = names[(indexPath as NSIndexPath).row]
        
        let address = cell.viewWithTag(2) as! UILabel
        address.text = addresses[(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toConfirm", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.title = " "
    }

}
