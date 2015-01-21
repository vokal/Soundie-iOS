//
//  LoginViewController.swift
//  Soundie
//
//  Created by Erik  Krag on 12/2/14.
//  Copyright (c) 2014 Kritters Kreations. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    private var authorizeHelper = AuthorizationUtility()
    
    @IBAction private func loginToSoundCloud(sender: UIButton) {
        let authorizeClosure: ((success: Bool, error: NSError?)->()) = { [unowned self] (success: Bool, error: NSError?) in
            if success {
                self.performSegueWithIdentifier("LoggedInSegue", sender: self);
            } else {
                println(error)
                let alert = AlertUtility.createAlertController(.AuthenticationFailure)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        if let viewControllerToPush = authorizeHelper.authorizeSoundCloud(authorizeClosure) {
            self.navigationController?.pushViewController(viewControllerToPush, animated: true)
        }
    }
}

