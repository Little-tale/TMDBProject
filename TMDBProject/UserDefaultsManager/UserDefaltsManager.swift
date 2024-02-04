//
//  UserDefaltsManager.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/4/24.
//

import UIKit

class UserDefaltsManager {
    private init() {}
    static let shared = UserDefaltsManager()
    
    let userDefaults = UserDefaults.standard
    
    enum setting {
        case userInfo
    }
    
    
    var userInfo: Bool {
        get{
            return userDefaults.bool(forKey: "userInfo")
        }
        set{
            userDefaults.set(newValue, forKey: "userInfo")
        }
    }
    
}
