//
//  WalkthroughContentViewController.swift
//  Mixit
//
//  Created by Cristhian Bolaños on 2/10/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

//Use this class to support multiple walkthrough screens
class WalkthroughContentViewController: UIViewController {
    
    //MAARK: -Outlets
    
    @IBOutlet var headinglabel: UILabel! {
        didSet {
            //this will allow the label to support multiple lines
            headinglabel.numberOfLines = 0
        }
    }
    @IBOutlet var subHeadingLabel: UILabel!{
        didSet{
            //this will allow the label to support multiple lines
            subHeadingLabel.numberOfLines = 0
        }
    }
    @IBOutlet var contentImageView: UIImageView!
    
    //MARK: - Properties
    var index = 0       //to store the current page index
    var heading = ""
    var subHeading = ""
    var imageFile = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //establish a connection between the UI components and the outlet variables
        headinglabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
