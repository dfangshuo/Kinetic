//
//  ConfirmationVC
//  wx-ios
//
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import JTAppleCalendar

extension ConfirmationVC: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        // You can set your date using NSDate() or NSDateFormatter. Your choice.
        formatter.dateFormat = "yyyy MM dd"
        //        formatter.timeZone = Calendar.current.timeZone
        //        formatter.locale = Calendar.locale
        
        let startDate = Date()
        print(startDate)
        
        let date = formatter.string(from: Date())
        let rightYear = date[0...3]
        
        let endDate = formatter.date(from: "\(rightYear) 12 31")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        handleSelection(cell: cell, cellState: cellState,date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "Calendar", for: indexPath) as! CalendarCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        
        cell.dateLabel.text = cellState.text
        cell.selectedLabel.text = cellState.text
        // mark out today's date
        formatter.dateFormat = "dd"
        
        if cellState.dateBelongsTo != .thisMonth {
            cell.dateLabel.textColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
            cell.dateLabel.backgroundColor = .white
        }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        firstDate = nil
        endDate = nil
        calendar.deselectAllDates()
        
        currDate = visibleDates.monthDates.first!.date
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: currDate!)
        
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: currDate!)
    }
    
    func handleSelection(cell: JTAppleCell?, cellState: CellState, date: Date?) {
        let myCustomCell = cell as! CalendarCell // You created the cell view if you followed the tutorial
        switch cellState.selectedPosition() {
        case .full, .left, .right:
            myCustomCell.selectedLabel.isHidden = false
            
            // Or you can put what ever you like for your rounded corners, and your stand-alone selected cell
            
        case .middle:
            myCustomCell.selectedLabel.isHidden = false
            
        default:
            myCustomCell.selectedLabel.isHidden = true

            
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        var dateComponent = DateComponents()
        dateComponent.day = -1
        guard let validCell = cell as? CalendarCell else {
            return
        }
        if firstDate != nil {
            if date == Calendar.current.date(byAdding: dateComponent, to: firstDate!){
                endDate = firstDate
                firstDate = Calendar.current.date(byAdding: dateComponent, to: firstDate!)
                validCell.selectedLabel.isHidden = false
                
            }
            else if date < firstDate! {
                endDate = firstDate
                firstDate = date
                calendar.selectDates(from: firstDate!, to: endDate!,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
                
            } else {
                endDate = date
                validCell.selectedLabel.isHidden = false
                calendar.selectDates(from: firstDate!, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            }
            
        } else {
            validCell.selectedLabel.isHidden = false
            firstDate = date
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = cell as? CalendarCell else {
            return
        }
        
        if firstDate != nil && endDate == nil {
            calendar.deselectAllDates()
            firstDate = nil
            validCell.selectedLabel.isHidden = true
            
        } else if firstDate == endDate {
            endDate = nil
            validCell.selectedLabel.isHidden = true
        } else if date != firstDate && date != endDate {
            throwAlert(title: "Time range must be continuous", msg: "Please select a start or end date")
        } else {
            validCell.selectedLabel.isHidden = true
            if date == endDate {
                var subtractOneDay = DateComponents()
                subtractOneDay.day = -1
                endDate = Calendar.current.date(byAdding: subtractOneDay, to: endDate!)
                //                print(endDate)
            } else {
                var addOneDay = DateComponents()
                addOneDay.day = 1
                firstDate = Calendar.current.date(byAdding: addOneDay, to: firstDate!)
                //                print(firstDate)
            }
        }
    }
}
