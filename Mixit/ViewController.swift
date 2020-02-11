//
//  ViewController.swift
//  Mixit
//
//  Created by Cristhian Bolaños on 2/9/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //this method will be call automatically
    override func viewDidAppear(_ animated: Bool) {
        //User this method to bring up the walkthroughViewController
        print("Starting app")
        print(UserDefaults.standard.string(forKey: "userName") ?? "no hay nada")
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(identifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }

}

