//
//  CalendarViewController.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/12/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar

class CalendarViewController: UITabBarController {
    
    var challenge: String? = nil
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
}

extension CalendarViewController: JTAppleCalendarViewDataSource,
    JTAppleCalendarViewDelegate {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 07 01")! // You can use date generated from a formatter ALSO REMOVE THE FORCE UNWRAP
        let endDate = Date()                                // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .sunday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        cell.dayLabel.text = cellState.text
        return cell
    }
    
}
