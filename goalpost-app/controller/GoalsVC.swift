//
//  ViewController.swift
//  goalpost-app
//
//  Created by Admin on 9/11/18.
//  Copyright © 2018 mahmoud. All rights reserved.
//

import UIKit
import CoreData


let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreData()
        tableview.reloadData()
    }
    
    func fetchCoreData() {
        self.fetch { (complete) in
            if complete{
                if goals.count >= 1 {
                    tableview.isHidden = false
                }else {
                    tableview.isHidden = true
                }
            }
        }
    }


    @IBAction func addGoalButton(_ sender: Any) {
        print("add")
        guard let creatGoalVc = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {return}
        presentDetail(viewControllerToPresent: creatGoalVc)
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell
            else {
            return UITableViewCell()
        }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletAction = UITableViewRowAction(style: .destructive, title: "Delet") { (rowAction, indexpath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .default, title: "Add 1") { (rowAction, indexpeth) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
        
        deletAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        return[deletAction, addAction]
        
    }
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexpath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosengoal = goals[indexpath.row]
        
        if chosengoal.goalProgress < chosengoal.goalComplietionValue {
            chosengoal.goalProgress = chosengoal.goalProgress + 1

        }else {
            
            return
        }
        
        do{
            try managedContext.save()
           print("Sucess")
        }
        catch{
            debugPrint("could not set progress \(error.localizedDescription)")
        }

        
    }
    
    func removeGoal(atIndexPath imdexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goals[imdexPath.row])
    
        do{
            try managedContext.save()
            
        }
        catch{
            debugPrint("could not remove \(error.localizedDescription)")
        }
        
        
    }
    
    
    func fetch(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
          goals = try managedContext.fetch(fetchRequest)
            completion(true)
        }
        catch {
            debugPrint("could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
}

    
    

    
    
    

