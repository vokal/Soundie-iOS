//
//  AuthorizationUtility.swift
//  Soundie
//
//  Created by Erik  Krag on 12/2/14.
//  Copyright (c) 2014 Vokal. All rights reserved.
//

import Foundation

class AuthorizationUtility : NetworkingBaseClass {
    
    //MARK: URL's
    private let authorizationURLString = "https://soundcloud.com/connect"
    private let tokenUrlString = NetworkingBaseClass.apiStringForPath("oauth2/token")
    
    var isUserLoggedIn: Bool {
        get{
            if self.accessToken != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    func authorizeSoundCloud(completionClosure:(success: Bool, error: NSError?)->()) -> (GTMOAuth2ViewControllerTouch?)
    {
        func soundCloudAuth() -> GTMOAuth2Authentication
        {
            let tokenURL = NSURL(string: tokenUrlString)
            
            var auth = GTMOAuth2Authentication.authenticationWithServiceProvider(serviceName,
                                                                                 tokenURL: tokenURL,
                                                                                 redirectURI: SoundCloudRedirectUri,
                                                                                 clientID: SoundCloudClientID,
                                                                                 clientSecret: SoundCloudClientSecret) as GTMOAuth2Authentication
            
            return auth
        }
        
        let authUrl = NSURL(string: authorizationURLString)
        
        var authViewController = GTMOAuth2ViewControllerTouch.controllerWithAuthentication(soundCloudAuth(),
                                                                                           authorizationURL: authUrl,
                                                                                           keychainItemName: nil) { [unowned self]
                                                                                            (viewController: GTMOAuth2ViewControllerTouch!, auth: GTMOAuth2Authentication!,err: NSError!) -> Void in
            if auth.accessToken != nil {
                self.saveAccessToken(auth.accessToken)
                completionClosure(success: true, error: nil)
            } else {
                println(err)
                completionClosure(success: false, error: err)
            }
        } as GTMOAuth2ViewControllerTouch

        //TODO:might need to figure out why this can't be assigned
//        authViewController.browserCookiesURL = NSURL(string: apiBaseUrlString)
        
        return authViewController
    }
    
    private func saveAccessToken(accessToken: String) {
        SSKeychain.setPassword(accessToken, forService: serviceName, account: accountName)
    }
}