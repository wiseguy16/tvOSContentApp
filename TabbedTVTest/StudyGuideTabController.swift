//
//  StudyGuideTabController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 5/31/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit



class StudyGuideTabController: UITabBarController, UITabBarControllerDelegate {
    
    var aSeriesItem: SeriesItem!
    var theSettings: SeriesItem!
    var removeTheseVCs: [Int]?
    var apiString: String!
    var allControllers = [Bool]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        

//        allControllers = [true, true, true, true, true, true, true]
//         // [[self viewControllers] objectAtIndex:0]
//       let controllers = self.viewControllers
//        guard let removeVCs = removeTheseVCs else { return }
//        let skipVCs = removeVCs
//        for vcSkip in skipVCs {
//            allControllers[vcSkip] = false
//            print(vcSkip)
//        }
//        print(allControllers)
//        
//        if removeVCs.count > 0
//        {
//            var timesThruLoop = 0
//            var tempInt = 0
//            for vc in removeVCs
//            {
//                tempInt = vc - timesThruLoop
//                //detailVC.viewControllers?.remove(at: tempInt)
//                timesThruLoop = timesThruLoop + 1
//                
//            }
//        }
//
//        var controllerX = 0
//        
//        if allControllers[0] {
//        let vc = controllers?[controllerX] as! IntroductionViewController
//        vc.thisStudyURL = apiString
//        vc.xSeriesItem = aSeriesItem
//        vc.xSettings = theSettings
//            controllerX = controllerX + 1
//        }
//        if allControllers[1] {
//            let vc1 = controllers?[controllerX] as! ShareViewController
//            vc1.thisStudyURL = apiString
//            vc1.xSeriesItem = aSeriesItem
//            vc1.xSettings = theSettings
//            controllerX = controllerX + 1
//        }
//        if allControllers[2] {
//            let vc2 = controllers?[controllerX] as! SessionVideoViewController
//         //   vc.thisStudyURL = apiString
//            vc2.xSeriesItem = aSeriesItem
//            vc2.xSettings = theSettings
//            controllerX = controllerX + 1
//        }
//        if allControllers[3] {
//            let vc3 = controllers?[controllerX] as! HearGodViewController
//            //   vc.thisStudyURL = apiString
//               vc3.xSeriesItem = aSeriesItem
//               vc3.xSettings = theSettings
//            controllerX = controllerX + 1
//        }
//        if allControllers[4] {
//            let vc4 = controllers?[controllerX] as! CreateStoryViewController
//            //   vc.thisStudyURL = apiString
//               vc4.xSeriesItem = aSeriesItem
//               vc4.xSettings = theSettings
//            controllerX = controllerX + 1
//        }
//        if allControllers[5] {
//            let vc5 = controllers?[controllerX] as! DigDeeperViewController
//            //   vc.thisStudyURL = apiString
//               vc5.xSeriesItem = aSeriesItem
//               vc5.xSettings = theSettings
//            controllerX = controllerX + 1
//        }
//        if allControllers[6] {
//            let vc6 = controllers?[controllerX] as! SessResourcesViewController
//            //   vc.thisStudyURL = apiString
//               vc6.xSeriesItem = aSeriesItem
//               vc6.xSettings = theSettings
//            controllerX = controllerX + 1
//        }







        
        
//        if let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController {
//            if let testController = navController.childViewControllers.first as? MyViewController{
//                testController.data = data
//                self.tabBarController?.selectedIndex = 1
//            }
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        code
//    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // print("Should select viewController: \(viewController.title) ?")
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let arrayOfVcs = tabBarController.viewControllers
        
        
//        switch viewController
//        {
//        case is IntroductionViewController:
//            print("pick")
//            IntroductionViewController.aSeriesItem = aSeriesItem
//        default:
//            print("yoo")
//        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
