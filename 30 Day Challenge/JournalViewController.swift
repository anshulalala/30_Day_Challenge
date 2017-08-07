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

class JournalViewController: UIViewController, UITextViewDelegate {
   
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
    var keyboardIsUp = false

    //set overarching questions as dictionaries because I'll add more questions later for other challenges
    let questionOne: [Challenge.ChallengeType:String] = [.Med: "How difficult was it to focus during your meditation?", .Rest: "Did you have any trouble sleeping?", .Exer: "How long did you exercise today?", .Veg: "What did you eat today?"]
    let questionTwo: [Challenge.ChallengeType:String] = [.Med: "Have you noticed a difference in your attitude?", .Rest: "Have you noticed a difference in your attitude?", .Exer: "Have you noticed any changes?", .Veg: "How are you dealing with cravings?"]
    let questionThree: [Challenge.ChallengeType:String] = [.Med: "Was it challenging today?", .Rest: "Was it challenging today?", .Exer: "Was it challenging today?", .Veg: "Was it challenging today?"]
    let questionComplete: [Challenge.ChallengeType:String] = [.Med: "Did you complete the challenge today?", .Rest: "Did you complete the challenge today?", .Exer: "Did you complete the challenge today?", .Veg: "Did you complete the challenge today?"]
    
    //this here below is an instance of the challengetype
    var challengeType = Challenge.ChallengeType.Med
    var challengeType2 = Challenge.ChallengeType.Rest
    var challengeType3 = Challenge.ChallengeType.Exer
    var challengeType4 = Challenge.ChallengeType.Veg


    override func viewDidLoad() {
        
        answerOne.delegate = self
        answerTwo.delegate = self
        answerThree.delegate = self
        
        super.viewDidLoad()
        if let journal = journal {
            answerOne.text = journal.answerOne
            answerTwo.text = journal.answerTwo
            answerThree.text = journal.answerThree
            complete.selectedSegmentIndex = journal.completedQ ? 1 : 0
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(JournalViewController.keyboardWillGoUp(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(JournalViewController.keyboardWillGoDown(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //code to display the question for the label
        
        qOneLabel.text = questionOne[globalChallenge.challengeType] ?? ""
        qTwoLabel.text = questionTwo[globalChallenge.challengeType] ?? ""
        qThreeLabel.text = questionThree[globalChallenge.challengeType] ?? ""
        completeLabel.text = questionComplete[globalChallenge.challengeType] ?? ""

    }
    
    func keyboardWillGoUp(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(self.view.frame.maxY)
            print(self.answerThree.frame.maxY + (answerThree.superview?.frame.origin.y)!)
            print(answerTwo.frame.maxY)
            print(answerOne.frame.maxY)
            print(keyboardSize.height)
            if self.view.frame.maxY - (self.answerThree.frame.maxY + (answerThree.superview?.frame.origin.y)!
                + 80) < keyboardSize.height && answerThree.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height
                keyboardIsUp = true
            }
            
        }
        
    }
    
    func keyboardWillGoDown(notification : NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if keyboardIsUp {
                self.view.frame.origin.y += keyboardSize.height
                keyboardIsUp = false
            }
            
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        answerOne.resignFirstResponder()
        answerTwo.resignFirstResponder()
        answerThree.resignFirstResponder()
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveAndGoBack" {
            
            if journal == nil {
                //if there is no journal for today, create one
                let newJournal = CoreDataHelper.newJournal() //here an instance being created
                newJournal.date = Date() as NSDate //creates new date
                newJournal.answerOne = answerOne.text //saves q1
                newJournal.answerTwo = answerTwo.text //save q2
                newJournal.answerThree = answerThree.text //save q3
                newJournal.completedQ = complete.selectedSegmentIndex == 0 ? false : true //save completion
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
    
    
}
