//
//  UserDefaultsUtilities.swift
//  Mixit
//
//  Created by Telematica on 3/11/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultsUtilities {
    
    static func saveUser(name: String, email: String, photoUrl: String?){
        UserDefaults.standard.set(name, forKey: Constants.UserDefaultKey.NAME)
        UserDefaults.standard.set(email, forKey: Constants.UserDefaultKey.EMAIL)
        UserDefaults.standard.set(photoUrl, forKey: Constants.UserDefaultKey.PHOTO_URL)
    }
    
    static func getName() -> String?{
        
        return UserDefaults.standard.string(forKey: Constants.UserDefaultKey.NAME)
    }
    
    static func getEmail() -> String?{
        
        return UserDefaults.standard.string(forKey: Constants.UserDefaultKey.EMAIL)
    }
    
    static func getPhotoUrl() -> String?{
        
        return UserDefaults.standard.string(forKey: Constants.UserDefaultKey.PHOTO_URL)
    }
    
}
