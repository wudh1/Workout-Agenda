//
//  AgendaItem.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/19/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import Foundation

struct AgendaItem {
    var name : String
    var exercises : [Exercise]
    var date: Date
    
    init(exercises: [Exercise], name: String, date: Date) {
        self.name = name
        self.exercises = exercises
        self.date = date
    }
    init() {
        self.name = ""
        self.exercises = [Exercise]()
        self.date = Date()
    }
    init(name: String, date: Date) {
        self.name = name
        self.date = date
        self.exercises = [Exercise]()
    }
}
