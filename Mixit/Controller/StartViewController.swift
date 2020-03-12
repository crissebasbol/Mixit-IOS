//
//  ViewController.swift
//  Mixit
//
//  Created by Cristhian Bolaños on 2/9/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //this method will be call automatically
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            Utilities.transition(wich: Constants.Storyboard.TAB_BAR_STORYBOARD, where: Constants.Controller.TAB_BAR_VIEW_CONTROLLER, from: self, fullScreen: true, bundle: nil)
            return
        }
        //User this method to bring up the walkthroughViewController
        print("Starting app")
        print(UserDefaults.standard.string(forKey: "userName") ?? "no hay nada")
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(identifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }

}

