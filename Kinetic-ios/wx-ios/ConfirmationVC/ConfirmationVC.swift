//
//  ConfirmationVC
//  wx-ios
//
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Alamofire


class ConfirmationVC: UIViewController {
    var calendar: JTAppleCalendarView!
    var eventName: UITextField!
    
    // dates stored as a dictionary of int:strings
    // with nums 1-7 corresponding to Mon-Sun
    var days: [Int]!
    var dates: [String]!
    let formatter = DateFormatter()
    // startTime/endTime stored as a single integer, with integers corresponding to a particular time
    var startTime = 8
    var endTime = 22
    
    var firstDate: Date?
    var endDate: Date?

    let nc = NotificationCenter.default
    
    var year: UILabel!
    var month: UILabel!
    var currDate: Date?
    
    var tap: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        setUpNavBar()
        setupCalendar()
        nc.addObserver(self, selector: #selector(toAdd), name: NSNotification.Name(rawValue: "toAdd"), object: nil)
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        nc.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        let edgeLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(backtoMain))
        edgeLeft.edges = .left
        view.addGestureRecognizer(edgeLeft)
    }
    
    @objc func backtoMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nextAction() {
        dismissKeyboard()
        
        if firstDate == nil && endDate != nil {
            throwAlert(title: "Missing start date", msg: "Please choose a start date")
        } else if endDate == nil && firstDate == nil {
            throwAlert(title: "Missing date", msg: "Please choose a date")
        }
        else {
            if endDate == nil && firstDate != nil {
                endDate = firstDate
            }
        }
        
        makeRequest()
        
        self.performSegue(withIdentifier: "toDone", sender: self)
    }
    
    @objc func toAdd() {
        self.performSegue(withIdentifier: "toAddAvailability", sender: self)
        
    }
    
    @objc func clearSelection() {
        calendar.deselectAllDates()
        calendar.reloadData()
    }
    
    func makeRequest() {
        let _ = Alamofire.request(Constants.bookCarEndPoint, method: .get, parameters: ["state": "booked", "carId": "5124"]).responseString { json in
            print(json)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.title = " "
    }
    
    func throwAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        view.removeGestureRecognizer(tap)
    }
    
}

