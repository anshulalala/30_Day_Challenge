//
//  Journal.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/19/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import Foundation

class Journal {
    
    //do i need an init
    
    //MARK: Properties
    
   
    var answerOne: String
    var answerTwo = ""
    var answerThree = ""
    var completedQ = false
    var date = Date()
    //date implementation
    
    init(answerOne: String, date: Date = Date(), completedQ: Bool = false) {
        self.answerOne = answerOne
    }
    
    
    
}
