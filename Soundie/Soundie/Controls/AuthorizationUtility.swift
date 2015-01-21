//
//  AuthorizationUtility.swift
//  Soundie
//
//  Created by Erik  Krag on 12/2/14.
//  Copyright (c) 2014 Vokal. All rights reserved.
//

import Foundation

class AuthorizationUtility : NetworkingBaseClass {
    
    //Mark: Url's
    private let authorizationURLString = "https://soundcloud.com/connect"
    private var tokenUrlString: String {
            return NetworkingBaseClass.apiStringForPath("oauth2/token")
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
            if let authExists = auth {
                println(err)
                completionClosure(success: false, error: err)
            } else {
                self.saveAccessToken(auth.accessToken)
                completionClosure(success: true, error: nil)
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