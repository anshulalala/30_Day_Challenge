//
//  Challenge.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/19/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import Foundation

class Challenge {
    let userDefaultKey = "challenge"
    //MARK: Properties
    var dayJournals = [Journal?](repeating: nil, count: 30) //array of boolean to see if they completed the challenge for one day
    
    enum ChallengeType: String { //enum for different challenge that we're on
        //also is this global?? How do you check if it is or not
        case Med
        case Rest
        case Veg
        case Exer
    }
    
    var challengeType: ChallengeType
    
    //MARK: Initializers
    init(challengeType: ChallengeType?) {
        if let challengeType = challengeType {
            self.challengeType = challengeType
            // store in UD
            let defaults: UserDefaults = UserDefaults.standard
            defaults.setValue(challengeType.rawValue, forKey: userDefaultKey)
            
        } else {
            if let challenge = UserDefaults.standard.value(forKey: userDefaultKey) as? String {
                if let type = ChallengeType(rawValue: challenge) {
                    self.challengeType = type
                } else {
                    // set default challenge type
                    // store default ChallengeType.rawValue in user defaults
                }
            }
            
        }
    }
    
    
    

}
