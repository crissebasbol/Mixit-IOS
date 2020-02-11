//
//  WalkthroughPageViewController.swift
//  Mixit
//
//  Created by Cristhian Bolaños on 2/10/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: class {
    //adopt a protocol for delegate that tell its delegate to the current page index
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    //MARK: -Properties
    
    //Weak keyword for delegate to prevent memory leak
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    var pageHeadings = ["Prepare the best cockatils", "Create your own recipes", "Reminders", "Filer by liquors"]
    var pageSubHeadings = ["Get to prepare the best cocktails with our recipies, you will be the sensation!", "Create your own cocktails and save it in our system, so you won't forget", "Add reminders to the cocktails you want to prepare in the future", "Do you only have a few ingredients and you don't know what to prepare? Don't worry, we help you find the ideal cocktail!"]
    var pageImages = ["walkthrough1", "walkthrough2", "walkthrough3", "walkthrough4"]
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the dara source and the delegate to itself
        dataSource = self
        delegate = self
        
        //Create the first walthrough screen
        if let startintViewController = contentViewCroller(at: 0){
            setViewControllers([startintViewController], direction: .forward, animated: true, completion: nil)
        }
                

        // Do any additional setup after loading the view.
    }
    //MARK: - PageView Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewCroller(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewCroller(at: index)
    }
    
    func contentViewCroller(at index: Int) -> WalkthroughContentViewController?{
        if index < 0 || index >= pageHeadings.count{
            return nil
        }
        //Create a new view controller and pass suitable data
        //to instantiate a view controller in a storyboard we first create an instance of the specific storyabord
        let storyboard = UIStoryboard(name:"Onboarding", bundle: nil)
        //then you call the instantiate view controller, the method returns a generic view controller, so we use a downcast the object WalkthroughContentViewController
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController{
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }
    
    func forwardPage(){
        //when the method is called, it automatically creates the next content view controller, if the controller can be created, we call the contentViewController method and navegate to the next new controller. 
        currentIndex += 1
        if let nextViewController = contentViewCroller(at: currentIndex){
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //check if the transition is completed
        if completed{
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController{
                currentIndex = contentViewController.index
                //call update page index to inform the delegate
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
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
