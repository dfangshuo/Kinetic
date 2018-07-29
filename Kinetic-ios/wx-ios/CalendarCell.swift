//
//  CalendarCell.swift
//  wx-ios
//
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {
    
    var dateLabel: UILabel!
    var selectedView: UIView!
    var selectedLabel: UILabel!
    
    
    override func awakeFromNib() {
        //        dateLabel = UILabel(frame: contentView.frame)
        dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 43, height: 43))
        //        dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 43, height: 35))
        
        dateLabel.textAlignment = .center
        dateLabel.layer.borderColor = UIColor(red: 0.88, green: 0.92, blue: 0.96, alpha: 1).cgColor
        dateLabel.layer.borderWidth = 1
        dateLabel.textColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 14)

        dateLabel.layer.backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 1, alpha: 1).cgColor
        dateLabel.layer.cornerRadius = 4
        
        contentView.addSubview(dateLabel)
        
        selectedLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 43, height: 43))
        selectedLabel.textAlignment = .center
        selectedLabel.layer.borderColor = Constants.appBlue.cgColor
        selectedLabel.layer.borderWidth = 1
        selectedLabel.textColor = UIColor(red: 0.22, green: 0.17, blue: 0.18, alpha: 1)
        selectedLabel.font = UIFont.systemFont(ofSize: 14)
        selectedLabel.layer.backgroundColor = Constants.appBlue.cgColor
        selectedLabel.layer.cornerRadius = 4
        selectedLabel.isHidden = true
        contentView.addSubview(selectedLabel)
    }
}
