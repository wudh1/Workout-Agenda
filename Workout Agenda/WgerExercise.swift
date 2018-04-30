//
//  WgerExercise.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/27/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import Foundation

struct WgerExercise {
    var name : String
    var category : String
    var equipment : String
    var description : String
    var image1 : String
    var image2 : String
    init() {
        self.name = ""
        self.category = ""
        self.equipment = ""
        self.description = ""
        self.image1 = ""
        self.image2 = ""
    }
    init (name: String, category: String, equipment: String, description: String, image1: String, image2: String) {
        self.name = name
        self.category = category
        self.equipment = equipment
        self.description = description
        self.image1 = image1
        self.image2 = image2
    }
}
