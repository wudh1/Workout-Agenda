//
//  ViewController.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/19/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController {
    @IBOutlet weak var exerciseTableView: UITableView!
    //var temp = AgendaItem()
    var agendaItem : AgendaItem!
    @IBOutlet weak var exerciseAddButton: UIBarButtonItem!
    @IBOutlet weak var exerciseEditButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        
        navigationItem.title = agendaItem.name
    }
    
    @IBAction func exercisesEditButtonPressed(_ sender: UIBarButtonItem) {
        if exerciseTableView.isEditing {
            exerciseTableView.setEditing(false, animated: true)
            exerciseAddButton.isEnabled = true
            exerciseEditButton.title = "Edit"
        }
        else {
            exerciseTableView.setEditing(true, animated: true)
            exerciseAddButton.isEnabled = true
            exerciseEditButton.title = "Done"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditExerciseDetail" {
            let destination = segue.destination as! ExerciseDetailViewController
            let index = exerciseTableView.indexPathForSelectedRow!.row
            destination.tempExercise = agendaItem.exercises[index]
        }
        else {
            if let selectedPath = exerciseTableView.indexPathForSelectedRow {
                exerciseTableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromExerciseDetailViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! ExerciseDetailViewController
        if let indexPath = exerciseTableView.indexPathForSelectedRow {
            agendaItem.exercises[indexPath.row] = sourceViewController.tempExercise!
            exerciseTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        else {
            let newIndexPath = IndexPath(row: agendaItem.exercises.count, section: 0)
            agendaItem.exercises.append(sourceViewController.tempExercise!)
            exerciseTableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
}

extension ExercisesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        cell.textLabel?.text = agendaItem.exercises[indexPath.row].exercise
        let reps = agendaItem.exercises[indexPath.row].reps
        let sets = agendaItem.exercises[indexPath.row].sets
        cell.detailTextLabel?.text = "Sets: \(sets)  Reps: \(reps)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agendaItem.exercises.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            agendaItem.exercises.remove(at: indexPath.row)
            exerciseTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = agendaItem.exercises[sourceIndexPath.row]
        agendaItem.exercises.remove(at: sourceIndexPath.row)
        agendaItem.exercises.insert(itemToMove, at: destinationIndexPath.row)
    }
}

