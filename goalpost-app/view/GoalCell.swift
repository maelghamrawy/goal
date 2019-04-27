//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Admin on 9/11/18.
//  Copyright © 2018 mahmoud. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionlbl: UILabel!
    @IBOutlet weak var goaltypelbl: UILabel!
    @IBOutlet weak var goalprogresslbl: UILabel!
    @IBOutlet weak var CompletiionView: UIView!
    
    func configureCell(goal : Goal){
        self.goalDescriptionlbl.text = goal.goalDescription
        self.goaltypelbl.text = goal.goalType
        self.goalprogresslbl.text = String(goal.goalProgress)
        
        if goal.goalProgress == goal.goalComplietionValue {
            
            self.CompletiionView.isHidden = false
        } else {
            self.CompletiionView.isHidden = true
        }

}
}
