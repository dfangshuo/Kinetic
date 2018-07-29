
//
//  ViewController.swift
//  wx-ios
//
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var backdrop: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var enterPickUp: UIButton!
    @IBOutlet  weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeRequest()
    }
    
    @IBAction func enterPickUp_Pressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toTypeLocation", sender: self)
    }
    
    func setupUI() {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let navigationBar = (self.navigationController?.navigationBar)!
        navigationBar.isTranslucent = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        let logo = UIImageView(image:#imageLiteral(resourceName: "kinetic-white"))
        self.navigationItem.titleView = logo
        
        //        let addEvent = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addEventFunction))
        //let addEvent = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(planEventPressed))
        let logOut = UIBarButtonItem(image: #imageLiteral(resourceName: "exit"), style: .done, target: self, action: #selector(logOutAction))
        
        self.navigationItem.leftBarButtonItem = logOut
        // self.navigationItem.rightBarButtonItem = addEvent
        
        enterPickUp.layer.borderWidth = 1   
        enterPickUp.layer.borderColor = Constants.appGrey.cgColor
        
        backdrop.layer.borderWidth = 1
        backdrop.layer.borderColor = Constants.appGrey.cgColor
        
        downButton.layer.borderWidth = 1.5
        downButton.layer.borderColor = Constants.appGrey.cgColor
        downButton.layer.cornerRadius = 0.5 * downButton.bounds.size.width
        
    }
    
    @objc func logOutAction() {
        
    }
    
    func makeRequest() {
//        let url = ""
        let _ = Alamofire.request(Constants.bookCarEndPoint, method: .get, parameters: ["state": "available"]).responseString { json in
            print(json)
        }
    }

}

