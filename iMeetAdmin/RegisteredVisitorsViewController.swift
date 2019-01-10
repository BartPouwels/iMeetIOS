//
//  RegisteredVisitorsViewController.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 10-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RegisteredVisitorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Creating outlet for tableView
    @IBOutlet weak var tableView: UITableView!
    
    //Declaring the keys that form a new Evententry
    var receivedID = ""
    var receivedEventID = ""
    
    //ARray to store registered visitors temporary
    var VisitorArray = [Visitor]()
    
    var EvententryArray = [Evententry]()
    
    //action for receiving reverse segue from QR scanner
    @IBAction func ReverseQRScannerSegue(sender:UIStoryboardSegue) { }
    
    //Create an empty event, to be filled by previous ViewController
    var receivedEvent = Event(name: nil, date: nil, startTime: nil, endTime: nil, description: nil)
    
    //Define database reference and handeler
    var ref: DatabaseReference! = Database.database().reference()
    var databaseHandle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //If receivedID is filled, find the selected event with that id, and fill receivedEventID
        //Then link it with the visitor and add it to the evententry table in the database
        if receivedID != "" {
            //Get key of receivedEvent
            ref.child("Event").queryOrdered(byChild: "Name").queryEqual(toValue: receivedEvent.name).observe(.value) { (snapshot) in
                
                for events in snapshot.children.allObjects as![DataSnapshot]{
                    
                    //Filling received event id with event key
                    self.receivedEventID = events.key as String
                    
                    //Post evententry to database
                    let eventEntry : [String : AnyObject] = ["Eventid" : self.receivedEventID as AnyObject, "Visitorid" : self.receivedID as AnyObject]
                    
                    //add the form to the Firebase database
                    self.ref.child("Evententry").childByAutoId().setValue(eventEntry)
                    self.getRegisteredVisitorNames()
                }
            }
        }
        //If receivedID is not filled, that means there is no QR scanned
        //Then just get the selected event ID to get current registered visitors
        else {
            //Get key of receivedEvent
            ref.child("Event").queryOrdered(byChild: "Name").queryEqual(toValue: receivedEvent.name).observe(.value) { (snapshot) in
                for events in snapshot.children.allObjects as![DataSnapshot]{
                    //Filling received event id with event key
                    self.receivedEventID = events.key as String
                    self.getRegisteredVisitorNames()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRegisteredVisitorNames() {
        
        ref.child("Evententry").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.childrenCount>0 {
                
                self.EvententryArray.removeAll()
                
                for evententries in snapshot.children.allObjects as![DataSnapshot]{
                        
                    let evententryObject = evententries.value as? [String: AnyObject]
                    let evententryEventid = evententryObject?["Eventid"]
                    let evententryVisitorid = evententryObject?["Visitorid"]
                    
                    let evententry = Evententry(eventid: evententryEventid as! String?, visitorid: evententryVisitorid as! String?)
                    
                    if (evententry.eventid == self.receivedEventID){
                        self.EvententryArray.append(evententry)
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        ref.child("Visitor").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.childrenCount>0 {
                
                self.VisitorArray.removeAll()
                
                for evententries in self.EvententryArray {
                    
                    for visitors in snapshot.children.allObjects as![DataSnapshot]{
                        
                        //Only proceed if it is the visitor with key the same as visitorid
                        if (visitors.key == evententries.visitorid) {
                            
                            let visitorObject = visitors.value as? [String: AnyObject]
                            let visitorName = visitorObject?["Name"]
                            let visitorDate_of_birth = visitorObject?["Date"]
                            let visitorPhonenumber = visitorObject?["Phonenumber"]
                            let visitorEmail = visitorObject?["Email"]
                            let visitorInfo = visitorObject?["Info"]
                            
                            let visitor = Visitor(name: visitorName as? String, date_of_birth: visitorDate_of_birth as? String, phonenumber: visitorPhonenumber as? String, email: visitorEmail as? String, info: visitorInfo as? String)
                            
                            self.VisitorArray.append(visitor)
                        }
                    }
                }
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VisitorArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MyCell")
        cell.textLabel?.text = VisitorArray[indexPath.row].name
        
        return cell
    }
    
    //MARK: Buttonaction used to make shure receivedID is empty at first
    @IBAction func scannerButton(_ sender: Any) {
        receivedID = ""
    }
    
}
