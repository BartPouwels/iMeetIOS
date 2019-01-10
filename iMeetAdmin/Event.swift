//
//  Event.swift
//  iMeetAdmin
//
//  Created by Bart Pouwels on 09-04-18.
//  Copyright © 2018 Bart Pouwels. All rights reserved.
//

import Foundation

//Create public class Event, to access it everywhere in the project
public class Event {
    
    //declaration of properties
    var name: String?
    var date: String?
    var startTime: String?
    var endTime: String?
    var description: String?
    
    //initializer, linking the incoming parameters to the class properties
    init(name:String?, date:String?, startTime:String?, endTime:String?, description:String?) {
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.description = description
    }
}
