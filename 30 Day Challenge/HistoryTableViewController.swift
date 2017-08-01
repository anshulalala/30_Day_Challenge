//
//  HistoryTableViewController.swift
//  30 Day Challenge
//
//  Created by Anshula Singh on 7/28/17.
//  Copyright © 2017 Anshula Singh. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var allJournals = [Journal]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var receivedJournal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allJournals = CoreDataHelper.retrieveJournals()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allJournals.count 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalEntry", for: indexPath) as! JournalEntryCell

        let journal = allJournals[indexPath.row]
        
        // Configure the cell...
        cell.dateLabel.text = journal.dateConvert()
        cell.previewLabel.text = journal.answerOne ?? ""

        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            // 2
            if identifier == "toPastJournal" {
                // 3
                print("Transitioning to the Past Journal Entry")
                
                let indexPath = tableView.indexPathForSelectedRow! //force unwrap safe? 
                print("\(#function): \(allJournals.count)")
                let alljournals = allJournals[indexPath.row]
                
                let pastJournalViewController = segue.destination as! PastJournalViewController
                
                pastJournalViewController.journal = alljournals
            }
        }
    }
    
    @IBAction func unwindToHistoryTableViewController(_ segue: UIStoryboardSegue) {
        //
    }
 

}
