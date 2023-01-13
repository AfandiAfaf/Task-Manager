//
//  TaskViewController.swift
//  MyToDoList
//
//  Created by afaf on 03/01/2023.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datechanged(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTF.inputView = datePicker
        dateTF.text = formatDate(date: Date()) //initialiser à aujourd'hui
        datePicker.minimumDate = Date()

        // Do any additional setup after loading the view.
        textField.delegate = self
        descrField.delegate = self
        dateTF.delegate = self
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    @objc func datechanged(datePicker: UIDatePicker){
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        
        return formatter.string(from: date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveTask()
        return true
        //get red of the keyboard
    }
    
    var update: (() -> Void)?
    
  
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet var descrField: UITextField!
    @IBOutlet var textField: UITextField!

    
    @objc func saveTask(){
        guard let text = textField.text, !text.isEmpty else{
            return
        }
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        guard let text1 = descrField.text, !text1.isEmpty else{
            return
        }
        guard let text2 = dateTF.text, !text2.isEmpty else{
            return
        }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        UserDefaults().set(text1, forKey: "descrip_\(newCount)")
        
        UserDefaults().set(text2, forKey: "deadline_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }

}
