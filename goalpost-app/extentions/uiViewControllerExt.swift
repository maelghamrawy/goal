//
//  uiViewControllerExt.swift
//  goalpost-app
//
//  Created by Admin on 9/11/18.
//  Copyright © 2018 mahmoud. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func presentDetail(viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
    
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentSecondaryDetail(_ ViewContrrollerToPresent : UIViewController){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        guard let presentedViewController = presentedViewController else {return}
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(ViewContrrollerToPresent, animated: false, completion: nil)
        }
    }
    
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}

