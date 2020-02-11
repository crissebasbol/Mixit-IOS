//
//  WalkthroughViewController.swift
//  Mixit
//
//  Created by Cristhian Bolaños on 2/10/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {
    
    
    // MARK: - Outles
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var skipButton: UIButton!{
        didSet{
            skipButton.layer.cornerRadius = 15.0
            //any sublayers of the layer that extend outside its boundaries will be clipped to those boundaries
            skipButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var sigInButton: UIButton!
    
    // MARK: - Properties
    
    //this property stores reference to the WalkthroughPageViewController object, this will be used to find out the current index out the walkthrough screen
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    // MARK: - Actions
    
    @IBAction func skipButtonTapped(sender: UIButton){
        UserDefaults.standard.set("Cristhian", forKey: "userName")
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI(){
        if let index = walkthroughPageViewController?.currentIndex{
            switch index {
            case 0...2:
                skipButton.setTitle("SKIP", for: .normal)
            case 3:
                skipButton.setTitle("START", for: .normal)
            default:
                break
            }
            //change the indicator of the page control
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //the container view connects with the walkthroughPageViewController through an embed seque, with the prepare method we get the reference of walkthroughPageViewController
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController{
            walkthroughPageViewController = pageViewController
            //asign the walkthroughDelegate
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }

}
