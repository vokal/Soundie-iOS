//
//  AlertUtility.swift
//  Soundie
//
//  Created by Erik  Krag on 12/9/14.
//  Copyright (c) 2014 Vokal. All rights reserved.
//

import Foundation

import UIKit

class AlertUtility {
    enum alertType {
        case AuthenticationSuccess
        case AuthenticationFailer
    }
    
    class func createAlertController (type: alertType) -> UIAlertController {
        var alertController: UIAlertController
        
        switch type { //TODO: Make Localized
        case .AuthenticationSuccess :
            alertController = UIAlertController(title: "Authorization Successful",
                                                message: "You have successfully authorized Soundie!",
                                                preferredStyle: .Alert)
        case .AuthenticationFailer :
            alertController = UIAlertController(title: "Error",
                                                message: "There was an error Authenticating Please Try again",
                                                preferredStyle: .Alert)
        }
        alertController.addAction(UIAlertAction(title: "Dismiss",
                                                style: .Cancel,
                                                handler: nil))
        
        return alertController
    }
}