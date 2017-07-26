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
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let formatter = DateFormatter()
    
    var challenge: String? = nil
    
    var todaysJournal: Journal?
    
    var receivedJournal: Journal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarView()
        
    }
    
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let journal = CoreDataHelper.retrieveCurrentJournal(date: Date()) {
            self.todaysJournal = journal
            //            if date != Date() { answerOne.isUserInteractionEnabled = false }
            
        }
    }
    
    @IBAction func unwindToCalendarVC(_ segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdd" {
            let destinationVC = segue.destination as! JournalViewController
            destinationVC.journal = todaysJournal
        }
        
        
    }
    
    
}


extension CalendarViewController: JTAppleCalendarViewDataSource {
    
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
    
}
    
    
    extension CalendarViewController: JTAppleCalendarViewDelegate {
        
        //display the cell
        func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
            
            let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
            cell.dateLabel.text = cellState.text
            return cell
        }
        
        func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
            guard let validCell = cell as? CustomCell else { return }
            validCell.selectedView.isHidden = false
        }
        
        func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
            guard let validCell = cell as? CustomCell else { return }
            
        }
        
            
        }
        
    
    

    

