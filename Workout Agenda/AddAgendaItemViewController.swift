//
//  AddAgendaItemViewController.swift
//  Workout Agenda
//
//  Created by Dan Wu on 4/25/18.
//  Copyright © 2018 Wu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddAgendaItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addAgendaSaveButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var agendaName: UITextField!
    @IBOutlet weak var motivationalQuote: UITextView!
    var incomingAgendaItem : AgendaItem!
    var quote = ""
    var quoteAuthor = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        addOrDisableSaveButton()
        agendaName.delegate = self
        loadQuote {
            self.motivationalQuote.text = "\(self.quote) - \(self.quoteAuthor)"
        }
    }
    
    func loadQuote(completed: @escaping ()-> ()) {
        Alamofire.request("https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let one = json["quoteText"].string {
                    self.quote = String(one)
                }
                else {
                    print("Could not find quote")
                }
                if let two = json["quoteAuthor"].string {
                    self.quoteAuthor = String(two)
                }
                else {
                    print("Could not find author")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
    
    @IBAction func editingAgendaNameTextField(_ sender: UITextField) {
        addOrDisableSaveButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromAddAgendaItem" {
            incomingAgendaItem = AgendaItem(name: agendaName.text!, date: datePicker.date)
        }
    }
    @IBAction func returnKeyPressed(_ sender: UITextField) {
        agendaName.resignFirstResponder()
    }
    
    
    func addOrDisableSaveButton() {
        let addAgendaNameCount = agendaName.text?.count
        if addAgendaNameCount! > 0 {
            addAgendaSaveButton.isEnabled = true
        } else {
            addAgendaSaveButton.isEnabled = false
        }
    }
    
    @IBAction func addAgendaItemCancelled(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
