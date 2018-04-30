//
//  ExerciseDetailViewController.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/19/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var exerciseDetailNameTextField: UITextField!
    @IBOutlet weak var exerciseDetailRepsTextField: UITextField!
    @IBOutlet weak var exerciseDetailSetsTextField: UITextField!
    @IBOutlet weak var exerciseDetailCommentsTextField: UITextView!
    @IBOutlet weak var exerciseDetailSaveButton: UIBarButtonItem!
    
    var tempExercise: Exercise!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tempExercise = tempExercise {
            exerciseDetailNameTextField.text = tempExercise.exercise
            exerciseDetailSetsTextField.text = String(tempExercise.sets)
            exerciseDetailRepsTextField.text = String(tempExercise.reps)
            exerciseDetailCommentsTextField.text = tempExercise.comments
            self.navigationItem.title = "Edit Exercise"
        }
        else {
            self.navigationItem.title = "New Exercise"
        }
        enableDisableSaveButton()
        exerciseDetailNameTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromExerciseDetail" {
            tempExercise = Exercise(exercise: exerciseDetailNameTextField.text!, sets: Int(exerciseDetailSetsTextField.text!)!, reps: Int(exerciseDetailRepsTextField.text!)!, comments: exerciseDetailCommentsTextField.text!)
        }
    }
    
    func enableDisableSaveButton() {
        let exerciseDetailNameTextFieldCount = exerciseDetailNameTextField.text?.count
        let exerciseDetailRepsTextFieldCount = exerciseDetailRepsTextField.text?.count
        let exerciseDetailSetsTextFieldCount = exerciseDetailSetsTextField.text?.count
        if exerciseDetailNameTextFieldCount! > 0 && exerciseDetailRepsTextFieldCount! > 0 && exerciseDetailSetsTextFieldCount! > 0 {
            exerciseDetailSaveButton.isEnabled = true
        } else {
            exerciseDetailSaveButton.isEnabled = false
        }
    }
    
    @IBAction func exerciseDetailNameChanged(_ sender: UITextField) {
        enableDisableSaveButton()
    }
    @IBAction func exerciseDetailSetsChanged(_ sender: UITextField) {
        enableDisableSaveButton()
    }

    @IBAction func exerciseDetailRepsChanged(_ sender: UITextField) {
        enableDisableSaveButton()
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        exerciseDetailNameTextField.resignFirstResponder()
    }
    
    @IBAction func exerciseDetailCancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
