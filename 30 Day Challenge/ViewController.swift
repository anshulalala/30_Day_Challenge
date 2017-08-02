//
//  ViewController.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/12/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
//    @IBOutlet weak var meditate: UIButton!
//    @IBOutlet weak var rest: UIButton!
//    @IBOutlet weak var veg: UIButton!
//    @IBOutlet weak var exer: UIButton!
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if today > Userdef.st.obj("lastDay") as? Date
        //renew dates:
        let startDate = Date()
        UserDefaults.standard.set(startDate, forKey: "firstDay")
        let endDate = thisDayOfNextMonth(date: startDate)
        UserDefaults.standard.set(endDate, forKey: "lastDay")
        //else
        //keep going with last

        
//        let journals = CoreDataHelper.retrieveJournals()
//        for j in journals {
//            CoreDataHelper.delete(journal: j)
//        }
        // Do any additional setup after loading the view, typically from a nib.
//        if UserDefaults.standard.value(forKey: "hasExisted") == nil {
//            UserDefaults.standard.set(false, forKey: "hasUserExisted")
//            
//        }
//        if UserDefaults.standard.value(forKey: "hasExisted") as! Bool == true {
//            performSegue(withIdentifier: "homeView", sender: nil)
//        }
        

    }

    @IBAction func pressMed(_ sender: Any) {
        performSegue(withIdentifier: "homeView", sender: self)
        //print("Meditation Pressed")
        /*
        let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue("Meditation", forKey: "challenge")
        */
        globalChallenge = Challenge(challengeType: .Med)
    }
    
    @IBAction func pressRest(_ sender: Any) {
        performSegue(withIdentifier: "homeView", sender: self)
        //print("Rest Pressed")
        /*
        let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue("Rest", forKey: "challenge")
        */
        globalChallenge = Challenge(challengeType: .Rest)
    }
   
    @IBAction func pressVeg(_ sender: Any) {
        performSegue(withIdentifier: "homeView", sender: self)
        //print("Veg Pressed")
        /*let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue("Veg", forKey: "challenge")
        */
        globalChallenge = Challenge(challengeType: .Veg)
    }
    
    @IBAction func pressExer(_ sender: Any) {
        performSegue(withIdentifier: "homeView", sender: self)
        //print("Exercise Pressed")
        /*let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue("Exercise", forKey: "challenge")
        */
        globalChallenge = Challenge(challengeType: .Exer)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func thisDayOfNextMonth(date: Date) -> Date {
       
        let startDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        var components = DateComponents()
        if startDateComponents.month! + 1 > 12 {
            components.year = startDateComponents.year! + 1
            components.month = 1
        } else {
            components.month = startDateComponents.month! + 1
        }
        
        components.day = startDateComponents.day
        components.hour = startDateComponents.hour
        components.minute = startDateComponents.minute
        components.second = startDateComponents.second
        
        let endDate = Calendar.current.date(from: components)
        return endDate!
    }


}

