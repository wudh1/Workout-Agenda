//
//  WgerLegsViewController.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/28/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WgerLegsViewController: UIViewController {

    @IBOutlet weak var wgerExercisesTableView: UITableView!
    var legExercises = [WgerExercise]()
    override func viewDidLoad() {
        super.viewDidLoad()
        wgerExercisesTableView.delegate = self
        wgerExercisesTableView.dataSource = self
        
        loadExercises {
            print("Done")
            self.updateUserInterface()
        }
        
    }
    
    func updateUserInterface() {
        wgerExercisesTableView.reloadData()
    }
    
    func loadExercises(completed: @escaping ()-> ()) {
        Alamofire.request("https://api.myjson.com/bins/kd6a7").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let allArms = json["total"]
                self.legExercises = []
                let total = allArms.count - 1
                for x in 0...total {
                    let tempName = json["total"][x]["Name"].stringValue
                    let tempCat = json["total"][x]["Category"].stringValue
                    let tempEquip = json["total"][x]["Equipment"].stringValue
                    let tempDescrip = json["total"][x]["Description"].stringValue
                    let tempImage1 = json["total"][x]["Image1"].stringValue
                    let tempImage2 = json["total"][x]["Image2"].stringValue
                    let tempWgerExercise = WgerExercise(name: tempName, category: tempCat, equipment: tempEquip, description: tempDescrip, image1: tempImage1, image2: tempImage2)
                    self.legExercises.append(tempWgerExercise)
                }
            case .failure(let error):
                print(error)
            }
            completed()
            
        }
    }
}

extension WgerLegsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegExercisesCell", for: indexPath) as! WgerLegsExerciseTableViewCell
        cell.update(input: legExercises[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legExercises.count
    }
}
