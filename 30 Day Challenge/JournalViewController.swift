//
//  JournalViewController.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/19/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class JournalViewController: UIViewController {
   
    @IBOutlet weak var complete: UISegmentedControl!
    
    @IBOutlet weak var answerOne: UITextView!
    
    @IBOutlet weak var answerTwo: UITextView!
    
    @IBOutlet weak var answerThree: UITextView!
   
    //@IBOutlet weak var journalLabel: UILabel!
    
    @IBOutlet weak var qOneLabel: UILabel!
    
    @IBOutlet weak var qTwoLabel: UILabel!
    
    @IBOutlet weak var qThreeLabel: UILabel!
    
    @IBOutlet weak var completeLabel: UILabel!
    
    var journal: Journal?
    
    
   
    //set overarching questions as dictionaries because I'll add more questions later for other challenges
    let questionOne: [Challenge.ChallengeType:String] = [.Med: "How difficult was it to focus for 10 minutes?", .Rest: "question"]
    let questionTwo = [Challenge.ChallengeType.Med: "Have you noticed a difference in your attitude?"]
    let questionThree = [Challenge.ChallengeType.Med: "Did you face any roadblocks while trying to complete the challenge today?"]
    let questionComplete = [Challenge.ChallengeType.Med: "Did you complete the challenge today?"]
    
    //this here below is an instance of the challengetype
    var challengeType = Challenge.ChallengeType.Med
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let journal = journal {
            answerOne.text = journal.answerOne
            answerTwo.text = journal.answerTwo
            answerThree.text = journal.answerThree
            complete.selectedSegmentIndex = journal.completedQ ? 1 : 0
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //code to display the question for the label
        print(qOneLabel)
        print(qTwoLabel)
        print(qThreeLabel)
        print(completeLabel)
        
        qOneLabel.text = questionOne[globalChallenge.challengeType] ?? ""
        qTwoLabel.text = questionTwo[globalChallenge.challengeType] ?? ""
        qThreeLabel.text = questionThree[globalChallenge.challengeType] ?? ""
        completeLabel.text = questionComplete[globalChallenge.challengeType] ?? ""

    }
    
   
//    @IBAction func saveToday(_ sender: Any) {
//        if journal == nil {
//            //if there is no journal for today, create one
//            let newJournal = CoreDataHelper.newJournal() //here an instance being created
//            newJournal.date = Date() as NSDate //creates new date
//            newJournal.answerOne = answerOne.text //saves q1
//            newJournal.answerTwo = answerTwo.text //save q2
//            newJournal.answerThree = answerThree.text //save q3
//            newJournal.completedQ = complete.selectedSegmentIndex == 0 ? false : true //save completion
//            CoreDataHelper.saveJournal()
//        //append into array for the ready stuff
//        //HistoryTableViewController.all
//        
//        } else {
//            //if there is a journal for today already created, change it
//            journal!.answerOne = answerOne.text
//            journal!.answerTwo = answerTwo.text
//            journal!.answerThree = answerThree.text
//            journal!.completedQ = complete.selectedSegmentIndex == 0 ? false : true
//            CoreDataHelper.saveJournal()
//        
//        }
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveAndGoBack" {
            
            if journal == nil {
                //if there is no journal for today, create one
                let newJournal = CoreDataHelper.newJournal() //here an instance being created
                newJournal.date = Date() as NSDate //creates new date
                newJournal.answerOne = answerOne.text //saves q1
                newJournal.answerTwo = answerTwo.text //save q2
                newJournal.answerThree = answerThree.text //save q3
                journal!.completedQ = complete.selectedSegmentIndex == 0 ? false : true //save completion
               CoreDataHelper.saveJournal()
            
                
                //HistoryTableViewController.allJournals.append(newJournal)
                
                //let destinationVC = segue.destination as! HistoryTableViewController
                //destinationVC.receivedJournal = newJournal
                
                //destinationVC.allJournals.append(newJournal)
               
                
                //don't need this code because we're not segueing, i just want the code to save
                let destinationVC = segue.destination as! CalendarViewController
                destinationVC.receivedJournal = newJournal

                //destinationVC.allJournals.append(newJournal)
            
            } else {
                //if there is a journal for today already created, change it
                journal!.answerOne = answerOne.text
                journal!.answerTwo = answerTwo.text
                journal!.answerThree = answerThree.text
                journal!.completedQ = complete.selectedSegmentIndex == 0 ? false : true
                CoreDataHelper.saveJournal()

                
                // let destinationVC = segue.destination as! HistoryTableViewController
                //destinationVC.receivedJournal = journal!
                
                //destinationVC.tableView.reloadData()
                
                let destinationVC = segue.destination as! CalendarViewController
                destinationVC.receivedJournal = journal!
            }
            
            
        }
    }
    
    
    
    //prepare segue check if the journal exists, and then check if the journal is nil 
    // then save a new journal -> instantiate a new journal into core data 
    // if it does exist, edit what is already in coredata by cross checking the date 
    //
    
}
