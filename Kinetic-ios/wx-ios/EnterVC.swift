//
//  EnterVC.swift
//  wx-ios
//
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import LocationPicker

class EnterVC: UIViewController {

    @IBOutlet weak var locTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        locTextField.becomeFirstResponder()
        let logo = UIImageView(image:#imageLiteral(resourceName: "kinetic-white"))
        self.navigationItem.titleView = logo
    }
    
    @IBAction func chooseLocation_Pressed(_ sender: Any) {
        let locationPicker = LocationPickerViewController()
        locationPicker.showCurrentLocationButton = true // default: true
        locationPicker.currentLocationButtonBackground = Constants.appBlue
        locationPicker.mapType = .standard // default: .Hybrid
        locationPicker.searchBarPlaceholder = "Where the party at" // default: "Search or enter an address"
        locationPicker.resultRegionDistance = 500 // default: 600
        
        locationPicker.completion = { location in
            self.performSegue(withIdentifier: "toLocations", sender: self)
        }
        self.present(locationPicker, animated: true)
    }

}
