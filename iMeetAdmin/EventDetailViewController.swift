//
//  EventDetailViewController.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 10-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //Create an empty event, to be filled by previous ViewController
    var receivedEvent = Event(name: nil, date: nil, startTime: nil, endTime: nil, description: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Assign received visitor properties to label content
        nameLabel.text = receivedEvent.name
        dateLabel.text = receivedEvent.date
        startTimeLabel.text = receivedEvent.startTime
        endTimeLabel.text = receivedEvent.endTime
        descriptionTextView.text = receivedEvent.description
        
        //Show event title in navigationbar
        self.title = receivedEvent.name!
        
        //Setting up border for TextView
        descriptionTextView!.layer.borderWidth = 1
        descriptionTextView!.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "registeredVisitorsSegue") {
            
            //set segue destination
            let destination = segue.destination as! RegisteredVisitorsViewController
            
            
            //Send the receivedEvent with the segue
            destination.receivedEvent = receivedEvent
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
