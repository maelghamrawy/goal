//
//  CreateGoalVc.swift
//  goalpost-app
//
//  Created by Admin on 9/11/18.
//  Copyright © 2018 mahmoud. All rights reserved.
//

import UIKit

class CreateGoalVc: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectColor()
        longTermBtn.serDeselectcolor()
        goalTextView.delegate = self
    }

    @IBAction func shortTermBtnpressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectColor()
        longTermBtn.serDeselectcolor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectColor()
        shortTermBtn.serDeselectcolor()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
        if goalTextView.text != "" && goalTextView.text != "what is your goals ?" {
            
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
            finishGoalVC.initData(description: goalTextView.text!, Type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
    
    
    
    
    
}
