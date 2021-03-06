//
//  AppDelegate.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/12/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import UIKit
import CoreData

var globalChallenge: Challenge!

let firstDayKey = "firstDay"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //let firstDayKey = "firstDay"

    
    //user default save the first date they open up the app
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        
        guard let challenge = UserDefaults.standard.value(forKey: "challenge") as? String,
                let startDate = UserDefaults.standard.object(forKey: "firstDay") as? Date else {
                    
                    let startDate = Date() //renew date to today's date and set it up
                    UserDefaults.standard.set(startDate, forKey: "firstDay")
                    let endDate = thisDayOfNextMonth(date: startDate)
                    UserDefaults.standard.set(endDate, forKey: "lastDay")
                    
                    let challengeVC = storyboard.instantiateInitialViewController()
                    self.window?.rootViewController = challengeVC
                    self.window?.makeKeyAndVisible()
                    
                    
                    
                    
                    return true

        }
        
        globalChallenge = Challenge(challengeType: Challenge.ChallengeType(rawValue: challenge))
        
        

        //This code digs deeper into the navigation and tab bar VC in order to go access Calendar
        
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as? UITabBarController {
            //create navigationVC and then access its topVC to assign chosen challenge
            if let navVC = tabBarVC.viewControllers?[0] as? UINavigationController {
                if let calendarVC = navVC.topViewController as? CalendarViewController {
                    calendarVC.challenge = challenge
                    
                    //set root as tabBarVC, since it will show its first VC
                    self.window?.rootViewController = tabBarVC
                    self.window?.makeKeyAndVisible()
                }
            }
            
            
        }
    
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
            //check to see if the current date is a month after the start date
        //if not, don't do anything
        let todayDate = Date()
        
        guard let endDate = UserDefaults.standard.object(forKey: "lastDay") as? Date
            else{
                let startDate = Date() //renew date to today's date and set it up
                UserDefaults.standard.set(startDate, forKey: "firstDay")
                let endDate = thisDayOfNextMonth(date: startDate)
                UserDefaults.standard.set(endDate, forKey: "lastDay")
                return
                
        }
            

        if todayDate > endDate {
            let startDate = Date() //renew date to today's date and set it up
            UserDefaults.standard.set(startDate, forKey: "firstDay")
            let endDate = thisDayOfNextMonth(date: startDate)
            UserDefaults.standard.set(endDate, forKey: "lastDay")
            
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
            let challengeVC = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = challengeVC
            self.window?.makeKeyAndVisible()
        
        
        
        }
            // if it is, have the app open the initial view for the storyboard

            
    
    

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "_0_Day_Challenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func thisDayOfNextMonth(date: Date) -> Date {
        
        let startDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        var components = DateComponents()
        //print(startDateComponents.year)
        if startDateComponents.month! + 1 > 12 {
            components.year = startDateComponents.year! + 1
            components.month = 1
        } else {
            components.month = startDateComponents.month! + 1
            components.year = startDateComponents.year

        }
        
        components.day = startDateComponents.day
        components.hour = startDateComponents.hour
        components.minute = startDateComponents.minute
        components.second = startDateComponents.second
        
        let endDate = Calendar.current.date(from: components)
        return endDate!
    }


}

