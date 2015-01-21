//
//  NetworkingBaseClass.swift
//  Soundie
//
//  Created by Erik  Krag on 12/17/14.
//  Copyright (c) 2014 Vokal. All rights reserved.
//

import Alamofire

class NetworkingBaseClass {
    
    private let privateServiceName = "SoundCloud Developer API"
    private let privateAccountName = "Soundie"
    
    //These lets the private constants be publically accessble in only the module
    func serviceName() -> String {
        return privateServiceName
    }
    func accountName() -> String {
        return privateAccountName
    }
    
    var accessToken: String? = SSKeychain.passwordForService("SoundCloud Developer API", account: "Soundie")

    /**
    Returns a URL for an Api String Path.
    
    :param: pathString This is the path that you want added to the base Url
    
    :returns: Will return an NSURL for the api as long as the pathString is well formed.
    */
    class func apiUrlForPath(pathString: String) -> NSURL? {
        return NSURL(string: apiStringForPath(pathString))
    }
    
    class func apiStringForPath(pathString: String) -> String {
        let apiBaseUrlString = "https://api.soundcloud.com"
        if pathString.hasPrefix("/") {
            return apiBaseUrlString + pathString
        } else {
            return apiBaseUrlString + "/" + pathString
        }
    }
    
}
