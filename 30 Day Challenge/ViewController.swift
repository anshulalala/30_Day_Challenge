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
        let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue("Rest", forKey: "challenge")
    }
   
    @IBAction func pressVeg(_ sender: Any) {
        performSegue(withIdentifier: "homeView", sender: self)
        //print("Veg Pressed")
        let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue("Veg", forKey: "challenge")
    }
    
    @IBAction func pressExer(_ sender: Any) {
        performSegue(withIdentifier: "homeView", sender: self)
        //print("Exercise Pressed")
        let defaults: UserDefaults = UserDefaults.standard
        defaults.setValue("Exercise", forKey: "challenge")
    }
    
    
    

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

