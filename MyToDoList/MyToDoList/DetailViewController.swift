//
//  DetailViewController.swift
//  MyToDoList
//
//  Created by afaf on 03/01/2023.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var desclabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dateField: UILabel!
    
    var task: String?
    var descrip: String?
    var deadline: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = task
        desclabel.text = descrip
        dateField.text = deadline
        
    }
    

}
