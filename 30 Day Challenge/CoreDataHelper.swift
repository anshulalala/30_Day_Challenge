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
    
    static func retrieveJournal() -> [Journal] {
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
