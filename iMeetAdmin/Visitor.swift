//
//  Visitor.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 09-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import Foundation

//Create public class Visitor, to access it everywhere in the project
public class Visitor {
    
    //declaration of properties
    var name: String?
    var date_of_birth: String?
    var phonenumber: String?
    var email: String?
    var info: String?
    
    //initializer, linking the incoming parameters to the class properties
    init(name:String?, date_of_birth:String?, phonenumber:String?, email:String?, info:String?) {
        self.name = name
        self.date_of_birth = date_of_birth
        self.phonenumber = phonenumber
        self.email = email
        self.info = info
    }
}
