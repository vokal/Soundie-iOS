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
    enum AlertType {
        case AuthenticationFailure
    }
    
    class func createAlertController(type: AlertType) -> UIAlertController {
        var alertController: UIAlertController
        
        switch type { 
        case .AuthenticationFailure :
            alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Alert Title For Authentication Failure"),
                                                message: NSLocalizedString("There was an error Authenticating Please Try again", comment: "Alert Message For Authentication Failure") ,
                                                preferredStyle: .Alert)
        }
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "Title for dismiss button"),
                                                style: .Cancel,
                                                handler: nil))
        
        return alertController
    }
}