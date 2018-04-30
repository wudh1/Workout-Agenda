//
//  Exercise.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/19/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import Foundation


struct Exercise {
    var exercise: String
    var sets: Int
    var reps: Int
    var comments: String
    
    init(exercise: String, sets: Int, reps: Int, comments: String) {
        self.exercise = exercise
        self.sets = sets
        self.reps = reps
        self.comments = comments
    }
    init() {
        self.exercise = ""
        self.sets = 0
        self.reps = 0
        self.comments = ""
    }
}
