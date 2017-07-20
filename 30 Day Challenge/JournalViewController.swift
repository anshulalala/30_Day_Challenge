//
//  JournalViewController.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/19/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import Foundation
import UIKit

class JournalViewController: ViewController {
    @IBOutlet weak var journalLabel: UILabel!
    @IBOutlet weak var qOneLabel: UILabel!
    @IBOutlet weak var qTwoLabel: UILabel!
    @IBOutlet weak var qThreeLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    
   
    let questionOne: [Challenge.ChallengeType:String] = [.Med: "How difficult was it to focus for 10 minutes?", .Rest: "question"]
    let questionTwo = [Challenge.ChallengeType.Med: "Have you noticed a difference in your attitude?"]
    let questionThree = [Challenge.ChallengeType.Med: "Did you face any roadblocks while trying to complete the challenge today?"]
    let questionComplete = [Challenge.ChallengeType.Med: "Did you complete the challenge today?"]
    
    
    //this here below is an instance of the challengetype
    var challengeType = Challenge.ChallengeType.Med
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        qOneLabel.text = questionOne[globalChallenge.challengeType] ?? ""
        
        
    }
    
}
