//
//  VisitorDetailViewController.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 05-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import UIKit

class VisitorDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var date_of_birthLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    //Create an empty visitor, to be filled by previous ViewController
    var receivedVisitor = Visitor(name: nil, date_of_birth: nil, phonenumber: nil, email: nil, info: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign received visitor properties to label content
        nameLabel.text = receivedVisitor.name
        date_of_birthLabel.text = receivedVisitor.date_of_birth
        phoneLabel.text = receivedVisitor.phonenumber
        emailLabel.text = receivedVisitor.email
        infoLabel.text = receivedVisitor.info
        
        //Show "Alle info van *name of visitor*" in navigationbar
        self.title = "Alle info van " + receivedVisitor.name!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
