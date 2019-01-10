//
//  EventTableViewController.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 10-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EventTableViewController: UITableViewController {
    
    //Array to store Events temporary
    var eventArray = [Event]()
    
    //Define database reference and handeler
    var ref: DatabaseReference! = Database.database().reference()
    var databaseHandle:DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("Event").observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0 {
                self.eventArray.removeAll()
                
                for events in snapshot.children.allObjects as![DataSnapshot]{
                    let eventObject = events.value as? [String: AnyObject]
                    let eventName = eventObject?["Name"]
                    let eventDate = eventObject?["Date"]
                    let eventStarttime = eventObject?["Starttime"]
                    let eventEndtime = eventObject?["Endtime"]
                    let eventDescription = eventObject?["Description"]
                    
                    let event = Event(name: eventName as! String?, date: eventDate as! String?, startTime: eventStarttime as! String?, endTime: eventEndtime as! String?, description: eventDescription as! String?)
                    
                    self.eventArray.append(event)
                }
                
                self.tableView.reloadData()
            }
        }
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
        return eventArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        let textToShow = eventArray[indexPath.row]
        cell.textLabel?.text = textToShow.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "eventDetailSegue") {
            
            //set segue destination
            let destination = segue.destination as! EventDetailViewController
            
            //get index number of selected cell as Int
            let indexPath = tableView.indexPathForSelectedRow!
            let rowNumber : Int = indexPath.row
            
            //use the index number to send the correct visitor with the segue
            destination.receivedEvent = eventArray[rowNumber]
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
