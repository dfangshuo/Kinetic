//
//  FinalVC.swift
//  wx-ios
//
//  Created by Fang on 7/29/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

class FinalVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupUI() {
        navigationItem.hidesBackButton = true
        self.title = "Reservation Confirmed"
        let logo = UIImageView(image:#imageLiteral(resourceName: "kinetic-white"))
        self.navigationItem.titleView = logo
    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToMain", sender: self)
    }
}
