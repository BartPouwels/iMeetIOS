//
//  AddEventViewController.swift
//  
//
//  Created by Bart Pouwels on 09-04-18.
//

import UIKit
import FirebaseDatabase

class AddEventViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    
    //Declare database reference
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fill database reference
        ref = Database.database().reference()
        
        //Function used for hiding the keyboard when tapped outside of the keyboard
        self.hideKeyboardWhenTappedAround()

        //Setting up border for TextView
        descriptionTextView!.layer.borderWidth = 1
        descriptionTextView!.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    //Function after clicking addEventButton
    @IBAction func AddEventButton(_ sender: Any) {
        
        //If not all fields are filled, display alert
        if nameTextField.text == "" || descriptionTextView.text == "" {
            
            //initialization of alert box
            let alert = UIAlertController(title: "Niet genoeg gegevens", message: "Vul alle velden in", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            
            //present alert
            self.present(alert, animated: true, completion: nil)
        }
            //If all fields are filled, continue saving the visitor
        else {
            
            //convert picked date to string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: startTimeDatePicker.date)
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "HH:mm"
            let startTimeString = dateFormatter2.string(from: startTimeDatePicker.date)
            let endTimeString = dateFormatter2.string(from: endTimeDatePicker.date)
            
            
            //create array and fill it with the data (key-value pair) from the form
            let event : [String : AnyObject] = ["Name" : nameTextField.text as AnyObject, "Date" : dateString as AnyObject, "Starttime" : startTimeString as AnyObject, "Endtime": endTimeString as AnyObject, "Description" : descriptionTextView.text as AnyObject]
            
            //add the form to the Firebase database
            ref.child("Event").childByAutoId().setValue(event)
            
            //Go back to previous ViewController
            navigationController?.popViewController(animated: true)
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
