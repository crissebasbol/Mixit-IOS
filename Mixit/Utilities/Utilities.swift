//
//  Utilities.swift
//  Mixit
//
//  Created by Telematica on 3/11/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class Utilities {
    
    static func checkEmptyField(text: String?, nameField: String?) -> String? {
        if text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            if (nameField != nil) {
                return "Please fill the " + nameField! + " field"
            }else{
                return "Please fill the field"
            }
        } else{
            return nil
        }
    }
    
    static func compareStrings(string1: String, string2: String) -> Bool {
        if string1 == string2 {
            return true
        } else{
            return false
        }
    }
    
    static func showAlert(title: String, message: String, controller: UIViewController){
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alert = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:  { (action) in
            ac.dismiss(animated: true, completion: nil)
        })
        ac.addAction(alert)
        controller.present(ac, animated: true, completion: nil)
    }
    
    static func transition(wich storyboard: String, where controller: String, from: UIViewController, fullScreen: Bool, bundle: Bundle?){
        let storyBoard: UIStoryboard = UIStoryboard(name: storyboard, bundle: bundle)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier:controller)
        if fullScreen {        tabBarViewController.modalPresentationStyle = .fullScreen
        }
        from.present(tabBarViewController, animated: true, completion: nil)
    }
    
    static func dismiss(_ controller: UIViewController){
        if controller.navigationController != nil{
            controller.navigationController?.popViewController(animated: true)
        }else{
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
}
