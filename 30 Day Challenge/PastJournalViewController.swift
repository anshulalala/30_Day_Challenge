//
//  PastJournalViewController.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/31/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import UIKit

class PastJournalViewController: UIViewController, UITextViewDelegate {
    
    //set overarching questions as dictionaries because I'll add more questions later for other challenges
    let questionOne: [Challenge.ChallengeType:String] = [.Med: "How difficult was it to focus during your meditation?", .Rest: "Did you have any trouble sleeping?", .Exer: "How long did you exercise today?", .Veg: "What did you eat today?"]
    let questionTwo: [Challenge.ChallengeType:String] = [.Med: "Have you noticed a difference in your attitude?", .Rest: "Have you noticed a difference in your attitude?", .Exer: "Have you noticed any changes?", .Veg: "How are you dealing with cravings?"]
    let questionThree: [Challenge.ChallengeType:String] = [.Med: "Was it challenging today?", .Rest: "Was it challenging today?", .Exer: "Was it challenging today?", .Veg: "Was it challenging today?"]
    let questionComplete: [Challenge.ChallengeType:String] = [.Med: "Did you complete the challenge today?", .Rest: "Did you complete the challenge today?", .Exer: "Did you complete the challenge today?", .Veg: "Did you complete the challenge today?"]
    
    //this here below is an instance of the challengetype
    var challengeType = Challenge.ChallengeType.Med
    
    @IBOutlet weak var complete: UISegmentedControl! //segment label
    
    @IBOutlet weak var answerOne: UITextView! //answer label
    
    @IBOutlet weak var answerTwo: UITextView!  //answer label
    
    @IBOutlet weak var answerThree: UITextView!  //answer label
    
    //@IBOutlet weak var journalLabel: UILabel!
    
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
            
            NotificationCenter.default.addObserver(self, selector: #selector(PastJournalViewController.keyboardWillGoUp(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(PastJournalViewController.keyboardWillGoDown(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            

        }
        
        answerOne.delegate = self
        answerTwo.delegate = self
        answerThree.delegate = self
        
        
        //code to display the question for the label
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        qOneLabel.text = questionOne[globalChallenge.challengeType] ?? ""
        qTwoLabel.text = questionTwo[globalChallenge.challengeType] ?? ""
        qThreeLabel.text = questionThree[globalChallenge.challengeType] ?? ""
        completeLabel.text = questionComplete[globalChallenge.challengeType] ?? ""

        
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



    //prepare segue check if the journal exists, and then check if the journal is nil
    // then save a new journal -> instantiate a new journal into core data
    // if it does exist, edit what is already in coredata by cross checking the date
    //
    
    func keyboardWillGoUp(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        
            if self.view.frame.maxY - self.answerThree.frame.maxY < keyboardSize.height && answerThree.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height
            }
            
        }
        
    }
    
    func keyboardWillGoDown(notification : NSNotification){
        self.view.frame.origin.y = 0
        
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
    
    
    
    
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //        ScrollView.setContentOffset(CGPointMake(0,250), animated: true)
    //
    //    }
    //
    //
    //
    //    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
    //        ScrollView.setContentOffset(CGPointMake(0,0), animated: true)
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  if segue.identifier == "saveAndGoBack" {
            
//            if journal == nil {
//                //if there is no journal for today, create one
//                let newJournal = CoreDataHelper.newJournal()
//                newJournal.date = Date() as NSDate
//                newJournal.answerOne = answerOne.text
//                newJournal.answerTwo = answerTwo.text
//                newJournal.answerThree = answerThree.text
//                //new segment control
//                newJournal.completedQ = complete.selectedSegmentIndex == 0 ? false : true
////                CoreDataHelper.saveJournal()
//               
//                let destinationVC = segue.destination as! HistoryTableViewController
//                destinationVC.receivedJournal = newJournal
//                
//                destinationVC.allJournals.append(newJournal)
//                
//            } else {
//                //if there is a journal for today already created, change it
//                journal!.answerOne = answerOne.text
//                journal!.answerTwo = answerTwo.text
//                journal!.answerThree = answerThree.text
//                journal!.completedQ = complete.selectedSegmentIndex == 0 ? false : true
////                CoreDataHelper.saveJournal()
//                let destinationVC = segue.destination as! HistoryTableViewController
//                destinationVC.receivedJournal = journal!
//                
//                destinationVC.tableView.reloadData()
//            }
        }
        
    
}
 
