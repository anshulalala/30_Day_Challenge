//
//  Journal+CoreDataProperties.swift
//  
//
//  Created by Anshula Singh on 8/1/17.
//
//

import Foundation
import CoreData


extension Journal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journal> {
        return NSFetchRequest<Journal>(entityName: "Journal")
    }

    @NSManaged public var answerOne: String?
    @NSManaged public var answerThree: String?
    @NSManaged public var answerTwo: String?
    @NSManaged public var completedQ: Bool
    @NSManaged public var date: NSDate?

    func dateConvert() -> String { //helps convert journal dates 
        if date == nil {
            return ""
        }
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM dd yyyy"
        return formatter.string(from: date! as Date)

    }
}
