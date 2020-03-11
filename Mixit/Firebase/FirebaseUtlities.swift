//
//  FirebaseUtlities.swift
//  Mixit
//
//  Created by Telematica on 3/11/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseUtilities {
    
    var controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    static func getName() -> String {
        
        return Auth.auth().currentUser?.displayName ?? ""
    }
    
    static func getPhotoUrl() -> String{
        let userPhotoURL = Auth.auth().currentUser?.photoURL
        var userPhoto: String = ""
        if userPhotoURL != nil {
            do{
                try userPhoto = String(contentsOf: userPhotoURL!)
                print("User photo URL successfully recovered: %@", userPhoto)
            }catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        return userPhoto
    }
    
}
