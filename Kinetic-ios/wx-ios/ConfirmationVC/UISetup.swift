//
//  ConfirmationVC
//  wx-ios
//
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import JTAppleCalendar

extension ConfirmationVC: UITextFieldDelegate {
    
    func setUpNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = "New Reservation"
        let next = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(nextAction))
        self.navigationItem.rightBarButtonItem = next
    }
    
    func setupFields() {
        view.layer.backgroundColor = UIColor.white.cgColor
        
        let nameRectangle = UILabel(frame:CGRect(x: -1, y: 31/667*view.frame.height, width: 432/375*view.frame.width, height: 51/667*view.frame.height))
        nameRectangle.backgroundColor = .white
        nameRectangle.layer.backgroundColor = UIColor.white.cgColor
        nameRectangle.layer.cornerRadius = 4
        nameRectangle.layer.borderWidth = 1
        nameRectangle.layer.borderColor = UIColor(red: 0.88, green: 0.92, blue: 0.96, alpha: 1).cgColor
        view.addSubview(nameRectangle)
        
        eventName = UITextField(frame: CGRect(x: 21/375*view.frame.width, y: 46/667*view.frame.height, width: 350/375*view.frame.width, height: 21/667*view.frame.height))
        eventName.adjustsFontSizeToFitWidth = true
        eventName.text = "Palo Alto"
        eventName.textColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1)
        eventName.font = UIFont.systemFont(ofSize: 14)
        eventName.delegate = self
        eventName.returnKeyType = .done
        view.addSubview(eventName)
        
        // 310
        let dateRectangle = UILabel(frame:CGRect(x: -1, y: 95/667*view.frame.height, width: 432, height: 435))
        //        let dateRectangle = UILabel(frame:CGRect(x: -1, y: 95/667*view.frame.height, width: 432/375*view.frame.width, height: 435/667*view.frame.height))
        
        dateRectangle.backgroundColor = .white
        dateRectangle.layer.backgroundColor = UIColor.white.cgColor
        dateRectangle.layer.cornerRadius = 4
        dateRectangle.layer.borderWidth = 1
        dateRectangle.layer.borderColor = UIColor(red: 0.88, green: 0.92, blue: 0.96, alpha: 1).cgColor
        view.addSubview(dateRectangle)
    }
    
    func setupCalendar() {
        let calendar = JTAppleCalendarView()
        calendar.frame = CGRect(x: -1, y: 188/667*view.frame.height, width: 368/375*view.frame.width, height: 310)
        calendar.register(CalendarCell.self, forCellWithReuseIdentifier: "Calendar")
        
        // calendar code
        calendar.calendarDelegate = self
        calendar.calendarDataSource = self
        calendar.backgroundColor = UIColor.clear
        calendar.showsVerticalScrollIndicator = false
        calendar.isPagingEnabled = true
        view.addSubview(calendar)
        
        setupDayLabels()
        
        // setting up range selection
        calendar.allowsMultipleSelection  = true
        
        month = UILabel(frame:CGRect(x: 17/375*view.frame.width, y: 111/667*view.frame.height, width: 250/375*view.frame.width, height: 60/667*view.frame.height))
        month.font = UIFont.systemFont(ofSize: 40/667*view.frame.height)
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: Date())
        month.textColor = Constants.appBlue
        view.addSubview(month)
        
        year = UILabel(frame:CGRect(x: 250/375*view.frame.width, y: 111/667*view.frame.height, width: 193/375*view.frame.width, height: 60/667*view.frame.height))
        year.font = UIFont.systemFont(ofSize: 50/667*view.frame.height)
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: Date())
        year.textColor = Constants.appBlack
        view.addSubview(year)
        
    }
    
    func setupDayLabels() {
        let yVal = 175/667*view.frame.height
        let h = 21/667*view.frame.height
        let w = 40/375*view.frame.width
        
        let sun = UILabel(frame:CGRect(x: 17/375*view.frame.width, y: yVal, width: w, height: h))
        sun.text = "SUN"
        sun.font = UIFont.systemFont(ofSize: 14)
        sun.textColor = UIColor(red: 0.35, green: 0.34, blue: 0.4, alpha: 1)
        view.addSubview(sun)
        
        let mon = UILabel(frame:CGRect(x: 69/375*view.frame.width, y: yVal, width: w, height: h))
        mon.text = "MON"
        mon.font = UIFont.systemFont(ofSize: 14)
        mon.textColor = UIColor(red: 0.35, green: 0.34, blue: 0.4, alpha: 1)
        view.addSubview(mon)
        
        let tue = UILabel(frame:CGRect(x: 122/375*view.frame.width, y: yVal, width: w + 2, height: h))
        tue.text = "TUES"
        tue.font = UIFont.systemFont(ofSize: 14)
        tue.textColor = UIColor(red: 0.35, green: 0.34, blue: 0.4, alpha: 1)
        view.addSubview(tue)
        
        let wed = UILabel(frame:CGRect(x: 175/375*view.frame.width, y: yVal, width: w, height: h))
        wed.text = "WED"
        wed.font = UIFont.systemFont(ofSize: 14)
        wed.textColor = UIColor(red: 0.35, green: 0.34, blue: 0.4, alpha: 1)
        view.addSubview(wed)
        
        let thu = UILabel(frame:CGRect(x: 230/375*view.frame.width, y: yVal, width: 50/375*view.frame.width, height: h))
        thu.text = "THU"
        thu.font = UIFont.systemFont(ofSize: 14)
        thu.textColor = UIColor(red: 0.35, green: 0.34, blue: 0.4, alpha: 1)
        view.addSubview(thu)
        
        let fri = UILabel(frame:CGRect(x: 284/375*view.frame.width, y: yVal, width: w, height: h))
        fri.text = "FRI"
        fri.font = UIFont.systemFont(ofSize: 14)
        fri.textColor = UIColor(red: 0.35, green: 0.34, blue: 0.4, alpha: 1)
        view.addSubview(fri)
        
        let sat = UILabel(frame:CGRect(x: 333/375*view.frame.width, y: yVal, width: w, height: h))
        sat.text = "SAT"
        sat.font = UIFont.systemFont(ofSize: 14)
        sat.textColor = UIColor(red: 0.35, green: 0.34, blue: 0.4, alpha: 1)
        view.addSubview(sat)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

