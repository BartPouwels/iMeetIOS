//
//  VisitorTableViewController.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 05-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class VisitorTableViewController: UITableViewController {
    
    //Array to store Visitors temporary
    var visitorArray = [Visitor]()
    
    //Define database reference and handeler
    var ref: DatabaseReference! = Database.database().reference()
    var databaseHandle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("Visitor").observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0 {
                self.visitorArray.removeAll()
                
                for visitors in snapshot.children.allObjects as![DataSnapshot]{
                    let visitorObject = visitors.value as? [String: AnyObject]
                    let visitorName = visitorObject?["Name"]
                    let visitorDate_of_birth = visitorObject?["Date_of_birth"]
                    let visitorPhonenumber = visitorObject?["Phonenumber"]
                    let visitorEmail = visitorObject?["Email"]
                    let visitorInfo = visitorObject?["Info"]
                    
                    let visitor = Visitor(name: visitorName as! String?, date_of_birth: visitorDate_of_birth as! String?, phonenumber: visitorPhonenumber as! String?, email: visitorEmail as! String?, info: visitorInfo as! String?)
                    
                    self.visitorArray.append(visitor)
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
        return visitorArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        let textToShow = visitorArray[indexPath.row]
        cell.textLabel?.text = textToShow.name

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "visitorDetailSegue") {
            
            //set segue destination
            let destination = segue.destination as! VisitorDetailViewController
            
            //get index number of selected cell as Int
            let indexPath = tableView.indexPathForSelectedRow!
            let rowNumber : Int = indexPath.row
            
            //use the index number to send the correct visitor with the segue
            destination.receivedVisitor = visitorArray[rowNumber]
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
