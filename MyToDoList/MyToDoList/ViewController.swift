//
//  ViewController.swift
//  MyToDoList
//
//  Created by afaf  on 03/01/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tasks = [String]()
    var details = [String]()
    var dates = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        
        cell.textLabel?.text = tasks[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*if (myTableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark) {
            myTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
        else {
            myTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            
        }*/
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        vc.title = "Task Details"
        vc.task = tasks[indexPath.row]
        vc.descrip = details[indexPath.row]
        vc.deadline = dates[indexPath.row]
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func didTapAddButton() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "enter") as? TaskViewController else{
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func updateTasks(){
        
        tasks.removeAll()
        details.removeAll()
        dates.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count")as? Int else {
            return
        }
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)")as? String {
                tasks.append(task)
            }
            if let descrip = UserDefaults().value(forKey: "descrip_\(x+1)")as? String {
                details.append(descrip)
            }
            if let deadline = UserDefaults().value(forKey: "deadline_\(x+1)")as? String {
                dates.append(deadline)
            }

        }
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.dataSource = self
        myTableView.delegate = self
        //the saving mecanism
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            
        }
        updateTasks()
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //tableView.beginUpdates()
            
            tasks.remove(at: indexPath.row)
            details.remove(at: indexPath.row)
            dates.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //tableView.endUpdates()
        }
        //myTableView.reloadData()
    }
    
    
}

