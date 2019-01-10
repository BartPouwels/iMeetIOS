//
//  AddVisitorViewController.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 08-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddVisitorViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var dateOfBirthDatePicker: UIDatePicker!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    
    //Declare database reference
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fill database reference
        ref = Database.database().reference()
        
        //Function used for hiding the keyboard when tapped outside of the keyboard
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    //Function after addVisitorButton click
    @IBAction func addVisitorButton(_ sender: Any) {
        
        //If not all fields are filled, display alert
        if nameTextfield.text == "" || phoneNumberTextField.text == "" || emailTextField.text == "" {
            
            //initialization of alert box
            let alert = UIAlertController(title: "Niet genoeg gegevens", message: "Vul de vereiste velden in", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            
            //present alert
            self.present(alert, animated: true, completion: nil)
        }
        //If all fields are filled, continue saving the visitor
        else {
            
            //convert picked date to string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: dateOfBirthDatePicker.date)
            
            //create array and fill it with the data (key-value pair) from the form
            let visitor : [String : AnyObject] = ["Name" : nameTextfield.text as AnyObject, "Date_of_birth" : dateString as AnyObject, "Phonenumber": phoneNumberTextField.text as AnyObject, "Email" : emailTextField.text as AnyObject, "Info" : infoTextField.text as AnyObject]
            
            //add the form to the Firebase database
            ref.child("Visitor").childByAutoId().setValue(visitor)
            
            //Go back to previous ViewController
            navigationController?.popViewController(animated: true)
        }
    }
}

//Extension to hide keyboard when tapped outside of the keyboard, the function is accessible from every UIViewController
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
