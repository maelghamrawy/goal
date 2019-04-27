//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Admin on 9/11/18.
//  Copyright © 2018 mahmoud. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var piontsTextField: UITextField!

    var goalDescription: String!
    var goalType: GoalType!

    func initData(description: String, Type: GoalType){
        self.goalDescription = description
        self.goalType = Type
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        piontsTextField.delegate = self

    }

    @IBAction func backBtn(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func CreateGoal(_ sender: Any) {
       // pass data to core model
        if piontsTextField.text != ""{
            self.save { (complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                }
            }
            
            
            
        }
        
        
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalComplietionValue = Int32(piontsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do{
            try managedContext.save()
            completion(true)
        }
        catch{
            debugPrint("loud not save \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
