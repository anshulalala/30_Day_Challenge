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

class CalendarViewController: UIViewController {
    let formatter = DateFormatter()
    
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
        
        formatter.dateFormat = "MM dd yyyy"
        
        formatter.timeZone = Calendar.current.timeZone
        
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "07 01 2017")! // You can use date generated from a formatter ALSO REMOVE THE FORCE UNWRAP
        let endDate = formatter.date(from: "07 31 2017")! //Date()                                
        // You can also use dates created from this function
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6)
                                                 //calendar: Calendar.current,
                                                 //generateInDates: .forAllMonths,
                                                 //generateOutDates: .tillEndOfGrid,
                                                 //firstDayOfWeek: .sunday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        return cell
    }
    
}
