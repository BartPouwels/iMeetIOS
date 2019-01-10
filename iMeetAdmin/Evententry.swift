//
//  Evententry.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 11-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import Foundation

//Create public class Evententry, to access it everywhere in the project
public class Evententry {
    
    //declaration of properties
    var eventid: String?
    var visitorid: String?
    
    //initializer, linking the incoming parameters to the class properties
    init(eventid:String?, visitorid:String?) {
        self.eventid = eventid
        self.visitorid = visitorid
    }
}
