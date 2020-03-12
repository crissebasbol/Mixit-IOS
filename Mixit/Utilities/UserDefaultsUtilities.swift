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
        print("Saving...")
        print(photoUrl ?? "Empty")
    }
    
    static func cleanUser(){
        UserDefaults.standard.set(nil, forKey: Constants.UserDefaultKey.NAME)
        UserDefaults.standard.set(nil, forKey: Constants.UserDefaultKey.EMAIL)
        UserDefaults.standard.set(nil, forKey: Constants.UserDefaultKey.PHOTO_URL)
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
    
    static func getFavourites() -> [Any]?{
        return UserDefaults.standard.array(forKey: Constants.CocktailDefaultKey.FAVOURITES)
    }
    
    static func setPhotoUrl(_ url: String){
        UserDefaults.standard.set(url, forKey: Constants.UserDefaultKey.PHOTO_URL)
    }
    
    static func setName(_ name: String){
        UserDefaults.standard.set(name, forKey: Constants.UserDefaultKey.NAME)
    }
    
    static func setFavourites(_ cocktail: [String: Any]) {
        if var favourites = self.getFavourites() {
            if !favourites.contains(where: {(($0 as! [String: Any])["id"] as? String) == (cocktail["id"] as? String)}) {
                favourites.append(cocktail)
                UserDefaults.standard.removeObject(forKey: Constants.CocktailDefaultKey.FAVOURITES)
                UserDefaults.standard.set(favourites, forKey: Constants.CocktailDefaultKey.FAVOURITES)
            }
        } else {
            UserDefaults.standard.set([cocktail], forKey: Constants.CocktailDefaultKey.FAVOURITES)
        }
    }
}
