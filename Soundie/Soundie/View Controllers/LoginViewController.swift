//
//  LoginViewController.swift
//  Soundie
//
//  Created by Erik Krag on 12/2/14.
//  Copyright (c) 2014 Kritters Kreations. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    private let authorizeHelper = AuthorizationUtility()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if authorizeHelper.isUserLoggedIn() {
            self.showStreamView()
        } //TODO:need to handle if authToken Expires
    }
    
    @IBAction private func loginToSoundCloud(sender: UIButton) {
        let authorizeClosure: ((success: Bool, error: NSError?) -> ()) = { [unowned self] (success: Bool, error: NSError?) in //TODO: might be able to remove this closure if the showStreamView is kept in the viewDidAppear.
            if success {
                self.showStreamView()
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
    
    private func showStreamView() {
        self.performSegueWithIdentifier("LoggedInSegue", sender: self)
    }
}

