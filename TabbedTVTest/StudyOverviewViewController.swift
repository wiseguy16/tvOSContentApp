//
//  StudyOverviewViewController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 5/19/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//
// WORKING VERSION JUNE 1st !!!!

import UIKit
import AVKit



class StudyOverviewViewController: UIViewController, CurrentSeriesAPIControllerProtocol {
    
    var anApiController: CurrentSeriesAPIController!
    
    var thisStudyURL: String?
    var thisIndividualStudy: SeriesItem?
    
    var currentSeriesItems = [SeriesItem]()
    var configSettingArray = [SeriesItem]()
    var thisSeries: SeriesItem!
    var seriesConfigSettings: SeriesItem!
    var assetLinks: [StudyAsset]? = []
    var colorPalette: [StudyColorGuide]? = []
    var sectionTitles: [SessionSection]? = []
    var sessions: [StudySession]? = []
    var tabTitles = [String]()
    
    var testInt = 1

    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var mainAuthorLabel: UILabel!
    @IBOutlet weak var mainTrailerImageView: UIImageView!
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var selectASessionLabel: UILabel!
    
    @IBOutlet weak var playTrailerButton: UIButton!
    
    
    @IBOutlet weak var sessionLabel1: UILabel!
    @IBOutlet weak var sessionLabel2: UILabel!
    @IBOutlet weak var sessionLabel3: UILabel!
    @IBOutlet weak var sessionLabel4: UILabel!
    @IBOutlet weak var sessionLabel5: UILabel!
    @IBOutlet weak var sessionLabel6: UILabel!
    @IBOutlet weak var sessionLabel7: UILabel!
    @IBOutlet weak var sessionLabel8: UILabel!
    @IBOutlet weak var sessionLabel9: UILabel!
    @IBOutlet weak var sessionLabel10: UILabel!
    @IBOutlet weak var sessionLabel11: UILabel!
    @IBOutlet weak var sessionLabel12: UILabel!
    
    @IBOutlet weak var week1Button: UIButton!
    @IBOutlet weak var week2Button: UIButton!
    @IBOutlet weak var week3Button: UIButton!
    @IBOutlet weak var week4Button: UIButton!
    @IBOutlet weak var week5Button: UIButton!
    @IBOutlet weak var week6Button: UIButton!
    @IBOutlet weak var week7Button: UIButton!
    @IBOutlet weak var week8Button: UIButton!
    @IBOutlet weak var week9Button: UIButton!
    @IBOutlet weak var week10Button: UIButton!
    @IBOutlet weak var week11Button: UIButton!
    @IBOutlet weak var week12Button: UIButton!
    
    
    @IBOutlet weak var navButton: UIButton!
    @IBOutlet weak var upLabel: UILabel!
    
    @IBOutlet weak var downLabel: UILabel!
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var focusAssistButton: UIButton!
    
    
    var designatedLastButton: UIButton?
   // var environments: [UIFocusEnvironment]?
    @IBOutlet weak var trailerButton: UIButton!
    
    @IBOutlet weak var coverView: UIView!
    
    
    
    var initialLabels = [UILabel]()
    var initialButtons = [UIButton]()
  //  var detailVC: StudyGuideTabController!
    var removeVCs: [Int] = []
    
    let focusGuide = UIFocusGuide()
    var prefEnvironments: [UIFocusEnvironment] = []

    
  //  fileprivate var focusGuide = UIFocusGuide()
    
    
    
    
    
    let baseURLString = "https://www.northlandchurch.net/api/get-study-guide-by-id/"

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLabels = [sessionLabel1, sessionLabel2, sessionLabel3, sessionLabel4, sessionLabel5, sessionLabel6, sessionLabel7, sessionLabel8, sessionLabel9, sessionLabel10] /* sessionLabel12, sessionLabel12*/
        initialButtons = [week1Button, week2Button, week3Button, week4Button, week5Button, week6Button, week7Button, week8Button, week9Button, week10Button]
        anApiController = CurrentSeriesAPIController(delegate: self)
        
        if thisStudyURL != nil
        {
            anApiController.getIndividualPreviousSeriesConfigurationDataFromNACD(baseURLString + thisStudyURL!)
        }
       // setUpMainScreen()
        if let useFirst = thisIndividualStudy?.studyGuideBGColor {
            let stringForColor = hexStringToUIColor(useFirst)
            coverView.backgroundColor = stringForColor
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpHelperFocus() {
        
            //focusGuide.preferredFocusEnvironments = [trailerButton]
            self.view.addLayoutGuide(focusGuide)
            focusGuide.leftAnchor.constraint(equalTo: focusAssistButton.leftAnchor, constant: 0).isActive = true
            focusGuide.rightAnchor.constraint(equalTo: focusAssistButton.rightAnchor, constant: 0).isActive = true
            focusGuide.topAnchor.constraint(equalTo: focusAssistButton.topAnchor, constant: 0).isActive = true
            focusGuide.bottomAnchor.constraint(equalTo: focusAssistButton.bottomAnchor, constant: 0).isActive = true
        }

    
    @IBAction func selectASessionTapped(_ sender: UIButton) {
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "StudyGuideTabController") as! StudyGuideTabController
        if currentSeriesItems.count > 0 && seriesConfigSettings != nil && sessions != nil
        {
            detailVC.aSeriesItem = currentSeriesItems[0] // seriesConfigSettings
            detailVC.theSettings = seriesConfigSettings
            
            detailVC.apiString = sessions?[sender.tag - 1].studyWeekURL
            detailVC.removeTheseVCs = removeVCs
            
            
            let dataStore = DataManager.sharedData
            dataStore.yThisStudyURL = sessions?[sender.tag - 1].studyWeekURL
            dataStore.ySeries = currentSeriesItems[0]
            dataStore.ySettings = seriesConfigSettings
            dataStore.sessionNumbrText = sender.currentTitle!
            dataStore.titlesArray = tabTitles


           // print(sessions?[sender.tag - 1].studyWeekURL)
            if tabTitles.count > 0
            {
                guard let vcs = detailVC.viewControllers else { return }
                var counter = 0
                for tab in tabTitles
                {
                    print("TabTitle")
                    print(tab)
                    vcs[counter].title = tab
                    counter = counter + 1
                }
            }
            if removeVCs.count > 0
            {
                var timesThruLoop = 0
                var tempInt = 0
                for vc in removeVCs
                {
                    tempInt = vc - timesThruLoop
                    detailVC.viewControllers?.remove(at: tempInt)
                    dataStore.titlesArray.remove(at: tempInt)
                    timesThruLoop = timesThruLoop + 1
                }
            }
             present(detailVC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func playTrailerTapped(_ sender: UIButton) {
        if seriesConfigSettings.trailerVideo != nil && seriesConfigSettings.trailerVideo != "" {
            let videoURL = URL(string: (seriesConfigSettings.trailerVideo)!)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupFocusGuide(with studySessions: [StudySession], buttons: [UIButton]) {
        
        // We create a focus guide to fill the space between the more infos button and the buy button since it's not obvious for the
        // focus engine which element should be focused.
        //self.view.addLayoutGuide(self.focusGuide)
        
        /*
         Left and top anchors
         buyButton is Top Right
         moreInfoButton is bottom left
        
           self.focusGuide.leftAnchor.constraint(equalTo: self.buyButton.leftAnchor).isActive = true
           self.focusGuide.topAnchor.constraint(equalTo: self.moreInfoButton.topAnchor).isActive = true
        
         Width and height
           self.focusGuide.widthAnchor.constraint(equalTo: self.buyButton.widthAnchor).isActive = true
           self.focusGuide.heightAnchor.constraint(equalTo: self.moreInfoButton.heightAnchor).isActive = true
        */
        
        let lastButtonIndex = studySessions.count - 1
        let lastButton = buttons[lastButtonIndex]
        designatedLastButton = lastButton
       // let multX = 2
        if studySessions.count <= 4 {
            prefEnvironments = buttons.reversed()
            setUpHelperFocus()
            focusGuide.preferredFocusEnvironments = [trailerButton]
           // prefEnvironments.insert(trailerButton, at: 0)
            /*
             NOT NEEDED ANYMORE!!!!!!
            navButton.alpha = 1
            navButton.isUserInteractionEnabled = true
            upLabel.alpha = 1
            downLabel.alpha = 1
            leftLabel.alpha = 1
            rightLabel.alpha = 1
 */
//            var cnt = studySessions.count
//            
//            switch cnt {
//            case 1:
//                multX = 4
//            case 2:
//                multX = 3
//            default:
//                multX = 2
//            }
            
            // Left and top anchors
          //  self.focusGuide.leftAnchor.constraint(equalTo: lastButton.leftAnchor).isActive = true
          //  self.focusGuide.topAnchor.constraint(equalTo: self.trailerButton.topAnchor, constant: 40.0).isActive = true
            
            
/*
            self.focusGuide.rightAnchor.constraint(equalTo: lastButton.rightAnchor).isActive = true
            self.focusGuide.bottomAnchor.constraint(equalTo: self.trailerButton.bottomAnchor).isActive = true
            self.focusGuide.leftAnchor.constraint(equalTo: self.trailerButton.rightAnchor).isActive = true
            self.focusGuide.topAnchor.constraint(equalTo: lastButton.bottomAnchor).isActive = true
*/
            
            // Width and height
           // var heightAncr: NSLayoutAnchor = self.trailerButton.frame.height
           // heightAncr = self.trailerButton.frame.height
//            var heightAncr = NSLayoutConstraint(item: focusGuide,
//                                                attribute: .height,
//                                                relatedBy: .greaterThanOrEqual,
//                                                toItem: trailerButton,
//                                                attribute: .height,
//                                                multiplier: 1.5,
//                                                constant: 4).isActive = true
       //     focusGuide.heightAnchor = heightAncr
            
            
         //   self.focusGuide.widthAnchor.constraint(equalTo: lastButton.widthAnchor, multiplier: 2.0).isActive = true
         //   self.focusGuide.heightAnchor.constraint(equalTo: self.trailerButton.heightAnchor, multiplier: CGFloat(multX)).isActive = true
        }
        
        
    }
    
        override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
            return true
        }
    
        override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//            if context.nextFocusedView == trailerButton
//            {
//                focusGuide.preferredFocusEnvironments = [trailerButton]
//
//               // setUpHelperFocus()
//                print("hello focus Next!!")
//            }
//             if context.nextFocusedView != trailerButton
//            {
//                focusGuide.preferredFocusEnvironments = prefEnvironments
//                print("hello focus Enviros!!")
//            }
            if context.previouslyFocusedView != trailerButton
            {
                focusGuide.preferredFocusEnvironments = [trailerButton]
                print("hello focus Enviros!!")
            }

            if context.previouslyFocusedView == trailerButton
            {
                focusGuide.preferredFocusEnvironments = prefEnvironments
              //  setUpHelperFocus()
                print("hello focus Previous!!")
    
            }
        }


    
    
    func setUpMainScreen() {
        colorPalette = seriesConfigSettings.studyColors
        guard let studySessionTitles: [StudySession] = seriesConfigSettings.studySessions else {
            return
        }
        setUpLabels(with: studySessionTitles)
        setUpButtons(with: studySessionTitles)
        
            
        UIView.animate(withDuration: 1) {
            if self.seriesConfigSettings.studyGuideBGColor != nil && self.seriesConfigSettings.studyGuideBGColor != "" {
                let bgColor = self.hexStringToUIColor((self.colorPalette?[8].hexColorString)!)
                self.view.backgroundColor = bgColor
            }
            
            let titleColor = self.hexStringToUIColor((self.colorPalette?[10].hexColorString)!)
            self.mainTitleLabel.text = self.seriesConfigSettings.title
            self.mainTitleLabel.textColor = titleColor
            
            let authorColor = self.hexStringToUIColor((self.colorPalette?[11].hexColorString)!)
            self.mainAuthorLabel.text = self.seriesConfigSettings.author
            self.mainAuthorLabel.textColor = authorColor
            
            let divColor = self.hexStringToUIColor((self.colorPalette?[12].hexColorString)!)
            self.dividerView.backgroundColor = divColor
            
            let placeHolder = UIImage(named: "WhiteBack.png")
            let myURL = self.seriesConfigSettings.trailerImage
            let realURL = URL(string: myURL!)
            self.mainTrailerImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])

    
        }
    }
    
    func setUpLabels(with studySessionTitles: [StudySession]) {
        let someLabels = initialLabels[0..<studySessionTitles.count]
        let extraLabels = initialLabels[studySessionTitles.count..<initialLabels.count]
        
        var index = 0
        for label in someLabels
        {
            label.text = studySessionTitles[index].studyWeekTitle
            index = index + 1
        }
        for extra in extraLabels
        {
            extra.text = ""
        }

        
    }
    
    func setUpButtons(with studySessionTitles: [StudySession]) {
        let someButtons = initialButtons[0..<studySessionTitles.count]
        let extraButtons = initialButtons[studySessionTitles.count..<initialButtons.count]
        var buttonTracker: [UIButton] = []
        
        //var index = 0
        for button in someButtons
        {
            button.alpha = 1
            buttonTracker.append(button)
            //environments?.append(button)
            //label.text = studySessionTitles[index].studyWeekTitle
            //index = index + 1
        }
        for extra in extraButtons
        {
            extra.alpha = 0
            extra.isUserInteractionEnabled = false
        }
        //environments?.append(trailerButton)
        setupFocusGuide(with: studySessionTitles, buttons: buttonTracker)

    }

}

extension StudyOverviewViewController {
    
    func gotTheSeries(_ theSeries: [SeriesItem]) {
        
        assetLinks?.removeAll()
        currentSeriesItems = theSeries   //theSeries
       // print(currentSeriesItems[0].session_create)
       // print(currentSeriesItems[0].session_devotional5_reflect)
        thisSeries = currentSeriesItems[0]
        adjustTabTitles()
        print(tabTitles)
        
        
        //checkDayOfWeek()
        
        if currentSeriesItems[0].studyAssets != nil
        {
            if currentSeriesItems[0].studyAssets!.count > 0
            {
                assetLinks = currentSeriesItems[0].studyAssets
            }
        }

        
        
      //  configureView()
        
        
//        UIView.animate(withDuration: 1.0, animations: {
//            self.coverView.alpha = 0
//            self.view.layoutIfNeeded()
//        })
       // loadingIndicator.stopAnimating()
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.5) {
            self.coverView.alpha = 0
            self.selectASessionLabel.alpha = 1
            self.trailerButton.alpha = 1
        }


    }
    
    func gotTheConfigSettings(_ theSettings: [SeriesItem]) {
        
        configSettingArray = theSettings
        seriesConfigSettings = configSettingArray[0]
        sessions = seriesConfigSettings.studySessions
        testInt = seriesConfigSettings.currentWeek!
        if configSettingArray[0].studySessions != nil
        {
            if configSettingArray[0].studySessions!.count > 0
            {
                print("sessionPickerButton could be enabled here")
                //sessionPickerButton.isUserInteractionEnabled = true
            }
            
        }
        
        if seriesConfigSettings.studySessions != nil
        {
            if seriesConfigSettings.studySessions!.count > 0
            {
                if let currentSeriesToGet = seriesConfigSettings.studySessions?[testInt - 1]
                {
                    if let useThisSessionFirst = currentSeriesToGet.studyWeekURL
                    {
                        anApiController.getPreviousSeriesDataFromNACD(useThisSessionFirst)  
                    }
                    
                }
            }
        }
        
        // ******************** STUFF FOR LOGIN VIEW ************************
        //
        //        if let picURL = configSettingArray[0].studyImage
        //        {
        //            let placeHolder = UIImage(named: "WhiteBack.png")
        //            let realURL = NSURL(string: picURL)
        //            loginImageView.sd_setImageWithURL(realURL, placeholderImage: placeHolder, options: .RefreshCached)
        //        }
        // ******************** STUFF FOR LOGIN VIEW ************************
        
        
        setUpMainScreen()
      //  setUpTheBackground()
        self.view.setNeedsLayout()
        

        
    }
    
    func adjustTabTitles()
    {
        if thisSeries.sessionSections != nil
        {
            if (thisSeries.sessionSections?.count)! > 0
            {
                sectionTitles = thisSeries.sessionSections
                var secIndx = 0
                for section in sectionTitles!
                {
                    guard let aLabel = section.sectionHeadline else { return }
                    
                        let headlineTitle = aLabel.stringByDecodingXMLEntities()
                        tabTitles.append(headlineTitle)

                    secIndx = secIndx + 1
                    
                    // print(section.sectionBody)
                    if section.sectionBody == "<p>not available</p>" || section.sectionBody == "" || secIndx == 3 || secIndx == 7
                    {
                        switch secIndx {
                        case 1:
                            removeVCs.append(secIndx - 1)
                            print("you got 1")
                        case 2:
                            removeVCs.append(secIndx - 1)
                            print("you got 2")
                        case 3:
                            removeVCs.append(secIndx - 1)
                            print("you got 3")
                        case 4:
                            removeVCs.append(secIndx - 1)
                            print("you got 4")
                        case 5:
                            removeVCs.append(secIndx - 1)
                            print("you got 5")
                        case 6:
                            removeVCs.append(secIndx - 1)
                            print("you got 6")
                        case 7:
                            removeVCs.append(secIndx - 1)
                            print("you got 7")
                        default:
                            print("you got a dud")
                        }
                        // adjust some constraint
                    }
                }
                tabTitles.append("Devotionals")

            }
        }
        /*
         1  Intro
         2  Share
         3  Video
         4  Hear
         5  Create
         6  Digging
         7  Resources
         */
    }
    
    func takeOutThisTitle(from theIndex: Int) {
       // detailVC.viewControllers?.remove(at: theIndex)
      //  detailVC.viewControllers?.remove(at: 1)
        print("This doesn't work !!z")
        
    }

}

extension UIViewController {
    
    func hexStringToUIColor (_ hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: (NSCharacterSet.whitespacesAndNewlines as NSCharacterSet) as CharacterSet).uppercased()
        
        //var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
