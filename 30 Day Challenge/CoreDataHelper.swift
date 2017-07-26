//
//  File.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/21/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
    
    let currentDate = Date()
    
    //static functions can be called without instantiating the class beforehand!!
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    static func newJournal() -> Journal {
        let journal = NSEntityDescription.insertNewObject(forEntityName: "Journal", into: managedContext) as! Journal
        return journal
    }
    
    static func saveJournal() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
            }
        
    }
    
   static func delete(journal: Journal) {
        managedContext.delete(journal)
        saveJournal()
    }
 
    
    static func retrieveCurrentJournal(date: Date) -> Journal? {
        let fetchRequest = NSFetchRequest<Journal>(entityName: "Journal")
//        fetchRequest.predicate = NSPredicate(format: "date == %@", date as NSDate)
        do {
            let mostRecentJournal: Journal?
            
            let results = try managedContext.fetch(fetchRequest)
            
            var sortedJournals = results.sorted(by: { $0.date!.compare($1.date! as Date) == .orderedDescending})
            
            if sortedJournals.count > 0 {
                mostRecentJournal = sortedJournals[0]
            } else {
                return nil
            }
            

            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            
            let journalDate = mostRecentJournal?.date
            let journalDateAsString = formatter.string(from: journalDate! as Date)
            
            let todaysDate = Date()
            let todaysDateAsString = formatter.string(from: todaysDate)
            
            
            if journalDateAsString == todaysDateAsString {
                return mostRecentJournal
            }
            
            return nil
            
            
//            for journal in sortedJournals {
//                let journalDate = journal.date
//                
//                let formatter = DateFormatter()
//                formatter.dateFormat = "MM/dd/yyyy"
//                
//                let journalDateAsString = formatter.string(from: journalDate as! Date)
//  
//            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
            return nil
        }
//        return mostRecentJournal //(or new journal?)
        
    }
    
    
    static func retrieveJournals() -> [Journal] {
        let fetchRequest = NSFetchRequest<Journal>(entityName: "Journal")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        
        return []
    
    }

}
