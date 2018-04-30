//
//  AgendaViewController.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/25/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController {

    @IBOutlet weak var agendaTableView: UITableView!
    let dateFormatter = DateFormatter()
    var tempAgendaArray = [AgendaItem]()
    var tempAgendaItem = AgendaItem(exercises: [Exercise(exercise: "Bench", sets: 3, reps: 10, comments: "Titties"), Exercise(exercise: "Plank", sets: 2, reps: 60, comments: "Abulars")], name: "Lift with Steph", date: Date())
    @IBOutlet weak var agendaAddButton: UIBarButtonItem!
    @IBOutlet weak var agendaEditButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        tempAgendaArray.append(tempAgendaItem)
        dateFormatter.dateFormat = ("MMM-dd-yyyy HH:mm")
        agendaTableView.delegate = self
        agendaTableView.dataSource = self
        
    }
    
    @IBAction func agendaEditButtonPressed(_ sender: UIBarButtonItem) {
        if agendaTableView.isEditing {
            agendaTableView.setEditing(false, animated: true)
            agendaAddButton.isEnabled = true
            agendaEditButton.title = "Edit"
        }
        else {
            agendaTableView.setEditing(true, animated: true)
            agendaAddButton.isEnabled = true
            agendaEditButton.title = "Done"
        }
    }
    
    @IBAction func unwindFromAddAgendaItemViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! AddAgendaItemViewController
        if let indexPath = agendaTableView.indexPathForSelectedRow {
            tempAgendaArray[indexPath.row] = sourceViewController.incomingAgendaItem!
            agendaTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        else {
            let newIndexPath = IndexPath(row: tempAgendaArray.count, section: 0)
            tempAgendaArray.append(sourceViewController.incomingAgendaItem!)
            agendaTableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromAgendaToExercises" {
            let destination = segue.destination as! ExercisesViewController
            let index = agendaTableView.indexPathForSelectedRow!.row
            destination.agendaItem = tempAgendaArray[index]
            
//            let destination = segue.destination as! ExercisesViewController
//            let index = agendaTableView.indexPathForSelectedRow!.row
//            destination.agendaItem = tempAgendaArray[index]
        }
        else {
            if let selectedPath = agendaTableView.indexPathForSelectedRow {
                agendaTableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
}

extension AgendaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaCell", for: indexPath)
        cell.textLabel?.text = tempAgendaArray[indexPath.row].name
        let date = self.dateFormatter.string(from: tempAgendaArray[indexPath.row].date)
        cell.detailTextLabel?.text = date
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempAgendaArray.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tempAgendaArray.remove(at: indexPath.row)
            agendaTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = tempAgendaArray[sourceIndexPath.row]
        tempAgendaArray.remove(at: sourceIndexPath.row)
        tempAgendaArray.insert(itemToMove, at: destinationIndexPath.row)
    }
}
