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
    
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var month: UILabel!
    
    @IBOutlet weak var challengeTitle: UILabel!
    
    let outsideMonthColor = UIColor(colorWithHexValue: 0xb1bfca)
    let monthColor = UIColor.white
    let selectedMonthColor = UIColor(colorWithHexValue: 0xffffff) //affects label color when selected
    let currentDateSelectedColor = UIColor(colorWithHexValue: 0xbabdbe)
    
    
    let formatter = DateFormatter()
    
    var challenge: String? = nil
    
    var todaysJournal: Journal?
    
    var receivedJournal: Journal?
    
    // MARK: allJournals array property: [Journal]?
    var allJournals = [Journal]()
    
    
    // TODO: ADD viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let journal = CoreDataHelper.retrieveCurrentJournal(date: Date()) {
            self.todaysJournal = journal
            //            if date != Date() { answerOne.isUserInteractionEnabled = false }
            
        }
    }

        
    
    // retrievejournals
    // update what calendar looks like
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarView()
        
    }
    
    func setupCalendarView() {
        
        //spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //month and year label
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
            
        }
        
        
        
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.year.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.month.text = self.formatter.string(from: date)
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            } else {
                validCell.dateLabel.textColor = outsideMonthColor
            }
            
        }
        
        
    }
   
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        
        if validCell.isSelected { //need this code so that extraneous selections aren't made
            validCell.selectedView.isHidden = false
        }
        else {
            validCell.selectedView.isHidden = true
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
                                                 numberOfRows: 6,
                                                 calendar: Calendar.current,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday)
        return parameters
    }
    
}
    
    
extension CalendarViewController: JTAppleCalendarViewDelegate {
        
        //display the cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
            
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        // TODO:
        // use date that gets passed in to access corresponding journal
            // need to caste date to NSDate type
            // filter through allJournals to find the journal where journal.date == date
        // if journal.completed => handle cell selected true
        
        
        cell.dateLabel.text = cellState.text
            
        handleCellSelected(view: cell, cellState: cellState)
        
        handleCellTextColor(view: cell, cellState: cellState)
       
        return cell
            }
        
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        //guard let validCell = cell as? CustomCell else { return }
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
            }
        
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
            //guard let validCell = cell as? CustomCell else { return }
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
            
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
            
}

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
        
    
    

    

