//
//  PastJournalViewController.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/31/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import UIKit

class PastJournalViewController: UIViewController {
    
    @IBOutlet weak var complete: UISegmentedControl! //segment label
    
    @IBOutlet weak var answerOne: UITextView! //answer label
    
    @IBOutlet weak var answerTwo: UITextView!  //answer label
    
    @IBOutlet weak var answerThree: UITextView!  //answer label
    
    @IBOutlet weak var journalLabel: UILabel!
    
    @IBOutlet weak var qOneLabel: UILabel!
    
    @IBOutlet weak var qTwoLabel: UILabel!
    
    @IBOutlet weak var qThreeLabel: UILabel!
    
    @IBOutlet weak var completeLabel: UILabel!
    
    var journal: Journal? //property that holds a journal
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let journal = journal {
            answerOne.text = journal.answerOne
            answerTwo.text = journal.answerTwo
            answerThree.text = journal.answerThree
            complete.selectedSegmentIndex = journal.completedQ ? 1 : 0
        }
        
        
        //code to display the question for the label
        qOneLabel.text = questionOne[globalChallenge.challengeType] ?? ""
        qTwoLabel.text = questionTwo[globalChallenge.challengeType] ?? ""
        qThreeLabel.text = questionThree[globalChallenge.challengeType] ?? ""
        completeLabel.text = questionComplete[globalChallenge.challengeType] ?? ""
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //unsure if i need this
        if let journal = journal {
            answerOne.text = journal.answerOne
            answerTwo.text = journal.answerTwo
            answerThree.text = journal.answerThree
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //set overarching questions as dictionaries because I'll add more questions later for other challenges
    let questionOne: [Challenge.ChallengeType:String] = [.Med: "How difficult was it to focus for 10 minutes?", .Rest: "question"]
    let questionTwo = [Challenge.ChallengeType.Med: "Have you noticed a difference in your attitude?"]
    let questionThree = [Challenge.ChallengeType.Med: "Did you face any roadblocks while trying to complete the challenge today?"]
    let questionComplete = [Challenge.ChallengeType.Med: "Did you complete the challenge today?"]
    
    //this here below is an instance of the challengetype
    var challengeType = Challenge.ChallengeType.Med
    
    
    
    //prepare segue check if the journal exists, and then check if the journal is nil
    // then save a new journal -> instantiate a new journal into core data
    // if it does exist, edit what is already in coredata by cross checking the date
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveAndGoBack" {
            
            if journal == nil {
                //if there is no journal for today, create one
                let newJournal = CoreDataHelper.newJournal()
                newJournal.date = Date() as NSDate
                newJournal.answerOne = answerOne.text
                newJournal.answerTwo = answerTwo.text
                newJournal.answerThree = answerThree.text
                CoreDataHelper.saveJournal()
               
                let destinationVC = segue.destination as! HistoryTableViewController
                destinationVC.receivedJournal = newJournal
                
                destinationVC.allJournals.append(newJournal)
                
            } else {
                //if there is a journal for today already created, change it
                journal!.answerOne = answerOne.text
                journal!.answerTwo = answerTwo.text
                journal!.answerThree = answerThree.text
                journal!.completedQ = complete.selectedSegmentIndex == 0 ? false : true
                
                let destinationVC = segue.destination as! HistoryTableViewController
                destinationVC.receivedJournal = journal!
                
                destinationVC.tableView.reloadData()
            }
        }
        
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("Cancel button tapped")
            }
    
        }
    }
    

    
    
    


}
