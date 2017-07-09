//
//  HearGodViewController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 6/1/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit
import AVKit
import SDWebImage

class HearGodViewController: UIViewController, CurrentSeriesAPIControllerProtocol, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var anApiController: CurrentSeriesAPIController!
    var assetLinks: [StudyAsset]? = []
    var currentSeriesItems = [SeriesItem]()
    var thisSeries: SeriesItem!
    var colorPalette: [StudyColorGuide]? = []
    
    var tvVideos: [TVCustomVideo]? = []
    
    @IBOutlet weak var seriesTitleLabel: UILabel!
    @IBOutlet weak var seriesAuthorLabel: UILabel!
    
    @IBOutlet weak var resourcesLabel: UILabel!
    
    @IBOutlet weak var scrollTextLabel: UILabel!
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scripVerseLabel: UILabel!
    
    @IBOutlet weak var tabTitleLabel: UILabel!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var resourcesCollection: UICollectionView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var rightSideView: UIView!
    
    
    @IBOutlet weak var smallDivider1: UIView!
    @IBOutlet weak var smallDivider2: UIView!
    
    @IBOutlet weak var upButton: UIButton!
    
    @IBOutlet weak var downButton: UIButton!
    
    @IBOutlet weak var goLeftButton: UIButton!
    
    @IBOutlet weak var goRightButton: UIButton!
    
    @IBOutlet weak var sessionLabel: UILabel!
    
    @IBOutlet weak var coverView: UIView!
    
    var numberOfIndexs = 0
    
    
    
    
    var thisStudyURL: String?
    var xSeriesItem: SeriesItem!
    var xSettings: SeriesItem!
    
    var scrollPosX = 0
    var scollPosY = 0
    var scrollPosition = CGPoint(x: 0, y: 0)
    var downTimer = Timer()
    
    
    let baseURLString = "https://www.northlandchurch.net/api/get-study-guide-by-id/"
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anApiController = CurrentSeriesAPIController(delegate: self)
        
        let dataStore = DataManager.sharedData
        thisStudyURL = dataStore.yThisStudyURL
        xSeriesItem = dataStore.ySeries
        xSettings = dataStore.ySettings
        
        let clrs = xSettings.studyColors
        if let coverStringColor = clrs?[8].hexColorString {
            let coverColor = hexStringToUIColor(coverStringColor)
            coverView.backgroundColor = coverColor
        }
        
        
        guard let sectionTextColorString = xSettings.studyColors?[14].hexColorString else { return }
        tabTitleLabel.textColor = hexStringToUIColor(sectionTextColorString)
        sessionLabel.textColor = hexStringToUIColor(sectionTextColorString)
        
        // ******************************************* CHANGE THIS PART!!!  ***********************************************************************************
       // tabTitleLabel.text = dataStore.titlesArray[3]
        
        
       // sessionLabel.text = dataStore.sessionNumbrText
        numberOfIndexs = dataStore.titlesArray.count
        
        
        
        
        
        //  print("IntroductionViewController string for thisStudyURL: " + thisStudyURL!)
        
        
        if thisStudyURL != nil
        {
            //anApiController.getIndividualPreviousSeriesConfigurationDataFromNACD(baseURLString + thisStudyURL!)
            anApiController.getCurrentSeriesDataFromNACD(thisStudyURL!)
        }
        
        //        bodyTextView.isUserInteractionEnabled = true
        //        bodyTextView.isSelectable = true
        //        bodyTextView.isScrollEnabled = true
        //
        //        bodyTextView.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouchType.indirect.rawValue)]
        guard let textBGColor = xSettings.studyColors?[9].hexColorString else { return }
        bodyTextView.backgroundColor = hexStringToUIColor(textBGColor)
        scripVerseLabel.backgroundColor = hexStringToUIColor(textBGColor)
        rightSideView.backgroundColor = hexStringToUIColor(textBGColor)
        
        guard let bgString = xSettings.studyColors?[8].hexColorString else { return }
        self.view.backgroundColor = hexStringToUIColor(bgString)
        
        // let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector(longPress))
        let longPressGestureRecognizer1 = UILongPressGestureRecognizer(target: self, action: #selector(longPressDown))
        let longPressGestureRecognizer2 = UILongPressGestureRecognizer(target: self, action: #selector(longPressUp))
        
        downButton.addGestureRecognizer(longPressGestureRecognizer1)
        upButton.addGestureRecognizer(longPressGestureRecognizer2)
        
        
        
        print("viewDidLoad on IntroductionViewController")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bodyTextView.setContentOffset(.zero, animated: true)
        //        if let firstIndex = tabBarController?.selectedIndex {
        //            if firstIndex == 0 {
        //                goLeftButton.isUserInteractionEnabled = false
        //                goLeftButton.alpha = 0.5
        //            }
        //        }
        //        if let lastIndex = tabBarController?.selectedIndex {
        //            if lastIndex == numberOfIndexs - 1 {
        //                goRightButton.isUserInteractionEnabled = false
        //                goRightButton.alpha = 0.5
        //            }
        //        }
//        if let selindx = tabBarController?.selectedViewController {
//            if selindx.isKind(of: IntroductionViewController.self) {
//                goLeftButton.isUserInteractionEnabled = false
//                goLeftButton.alpha = 0.5
//            }
//        }
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func longPressDown(longPressGestureRecognizer : UILongPressGestureRecognizer) {
        // Handle long press
        if longPressGestureRecognizer.state == UIGestureRecognizerState.ended {
            downTimer.invalidate()
        }
        else {
            startTimerButtonDownTapped()
        }
    }
    func longPressUp(longPressGestureRecognizer : UILongPressGestureRecognizer) {
        // Handle long press
        if longPressGestureRecognizer.state == UIGestureRecognizerState.ended {
            downTimer.invalidate()
        }
        else {
            startTimerButtonUpTapped()
        }
    }
    
    func startTimerButtonDownTapped() {
        downTimer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        downTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(downTimerAction1), userInfo: nil, repeats: true)
    }
    
    func startTimerButtonUpTapped() {
        downTimer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        downTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(upTimerAction1), userInfo: nil, repeats: true)
    }
    
    // called every time interval from the timer
    func downTimerAction1() {
        print("down")
        if bodyTextView.contentOffset.y <= ((bodyTextView.contentSize.height - bodyTextView.frame.size.height) - 20) {
            scrollPosition.y = scrollPosition.y + 20
            bodyTextView.setContentOffset(scrollPosition, animated: true)
        }
        else {
            downTimer.invalidate()
            print("timer stopped")
        }
        
    }
    
    func upTimerAction1() {
        print("down")
        if bodyTextView.contentOffset.y >= (20) {
            scrollPosition.y = scrollPosition.y - 20
            bodyTextView.setContentOffset(scrollPosition, animated: true)
        }
        else {
            downTimer.invalidate()
            print("timer stopped")
        }
        
    }
    
    
    
    
    
    @IBAction func scrollUpTapped(_ sender: UIButton) {
        if scrollPosition.y >= 20
        {
            scrollPosition.y = scrollPosition.y - 20
            bodyTextView.setContentOffset(scrollPosition, animated: true)
        }
    }
    
    @IBAction func scrollDownTapped(_ sender: UIButton) {
        
        if bodyTextView.contentOffset.y <= ((bodyTextView.contentSize.height - bodyTextView.frame.size.height) - 20) {
            scrollPosition.y = scrollPosition.y + 20
            bodyTextView.setContentOffset(scrollPosition, animated: true)
        }
        
    }
    
    @IBAction func nextSectionTapped(_ sender: UIButton) {
        
        if let thisIndex = tabBarController?.selectedIndex {
            print("This index is \(thisIndex)")
            tabBarController?.selectedIndex = 1 + thisIndex
        }
    }
    
    
    @IBAction func previousSectionTapped(_ sender: UIButton) {
        if let thisIndex = tabBarController?.selectedIndex {
            print("This index is \(thisIndex)")
            tabBarController?.selectedIndex = thisIndex - 1
        }
        
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var theInt = 0
        
        if tvVideos != nil
        {
            if (tvVideos?.count)! > 0
            {
                theInt = (tvVideos?.count)!
            }
        }
        else
        {
            theInt = 0
        }
        return theInt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myCell = UICollectionViewCell()
        
        // Configure the cell
        if collectionView == resourcesCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SessionCollectionViewCell", for: indexPath) as! SessionCollectionViewCell
            
            guard let aVid = tvVideos?[indexPath.row] else { return myCell }
            cell.sessionLabel.text = aVid.name
            
            
            let placeHolder = UIImage(named: "WhiteBack.png")
            let myURL = aVid.imageURLString
            let realURL = URL(string: myURL!)
            
            cell.sessionImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
            
            return cell
            
            
        }
        else
        {
            return myCell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vid = tvVideos?[indexPath.row] else { return }
        
        if vid.m3u8file != nil && vid.m3u8file != "" {
            let videoURL = URL(string: (vid.m3u8file)!)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
        }
        else
        {
            if vid.imageURLString != nil && vid.imageURLString != ""
            {
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "PicViewController") as! PicViewController
                detailVC.imageURLString = vid.imageURLString
                present(detailVC, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func setUpScreen() {
        
        colorPalette = xSettings.studyColors
        //        guard let studySessionTitles: [StudySession] = seriesConfigSettings.studySessions else {
        //            return
        //        }
        
        
        //        UIView.animate(withDuration: 1) {
        //            if self.seriesConfigSettings.studyGuideBGColor != nil && self.seriesConfigSettings.studyGuideBGColor != "" {
        //                let bgColor = self.hexStringToUIColor(self.seriesConfigSettings.studyGuideBGColor!)
        //                self.view.backgroundColor = bgColor
        //            }
        //        }
        
        let topTitleColor = self.hexStringToUIColor((self.colorPalette?[15].hexColorString)!)
        titleLabel.textColor = topTitleColor
        titleLabel.text = thisSeries.title
        
        
        let titleColor = self.hexStringToUIColor((self.colorPalette?[10].hexColorString)!)
        self.seriesTitleLabel.text = xSettings.title
        self.seriesTitleLabel.textColor = titleColor
        
        let authorColor = self.hexStringToUIColor((self.colorPalette?[11].hexColorString)!)
        self.seriesAuthorLabel.text = xSettings.author
        self.seriesAuthorLabel.textColor = authorColor
        
        let divColor = self.hexStringToUIColor((self.colorPalette?[12].hexColorString)!)
        dividerView.backgroundColor = divColor
        
        let smallDivColor = self.hexStringToUIColor((self.colorPalette?[12].hexColorString)!)
        smallDivider1.backgroundColor = smallDivColor
        smallDivider2.backgroundColor = smallDivColor
        
        
        
        let placeHolder = UIImage(named: "WhiteBack.png")
        let myURL = xSettings.studyImage
        let realURL = URL(string: myURL!)
        self.mainImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
        
        
        guard let part1 = thisSeries.session_memory_verse_ref else { return }
        let part1A = part1.replaceBreakWithReturn(part1)
        
        guard let part2 = thisSeries.session_memory_verse else { return }
        let part2A = part2.replaceBreakWithReturn(part2)
        scripVerseLabel.text = "\(part1A)\n\(part2A)"
        
        // ******************************************* CHANGE THIS PART!!!  ***********************************************************************************
        guard let tempText = thisSeries.session_hear?.stringByDecodingXMLEntities() else { return }
        
        
        bodyTextView.text = tempText.replaceBreakWithReturn(tempText)
        
        if let thisIndex = tabBarController?.selectedIndex {
            let dataStore = DataManager.sharedData
            thisStudyURL = dataStore.yThisStudyURL
            xSeriesItem = dataStore.ySeries
            xSettings = dataStore.ySettings
            
            tabTitleLabel.text = dataStore.titlesArray[thisIndex]
            sessionLabel.text = dataStore.sessionNumbrText

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
    
    @IBAction func exitTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}

extension HearGodViewController {
    // ******************************************* CHANGE THIS PART ABOVE!!!  ***********************************************************************************
    
    
    
    func gotTheSeries(_ theSeries: [SeriesItem]) {
        
        assetLinks?.removeAll()
        currentSeriesItems = theSeries
        thisSeries = currentSeriesItems[0]
        
        let sessVidImgString = thisSeries.videoSessionImage
        let sessVidM3U8String = thisSeries.mediaFileM3U8
        let sessCustVid = TVCustomVideo(name: "Session Video", imageURLString: sessVidImgString)
        sessCustVid.m3u8file = sessVidM3U8String
        tvVideos?.append(sessCustVid)
        
        //checkDayOfWeek()
        
        if currentSeriesItems[0].studyAssets != nil
        {
            if currentSeriesItems[0].studyAssets!.count > 0
            {
                assetLinks = currentSeriesItems[0].studyAssets
                guard let links = assetLinks else { return }
                for link in links
                {
                    let custVid = TVCustomVideo(name: link.assetTitle, imageURLString: link.assetURL)
                    
                    if link.assetDescrip != nil && link.assetDescrip != ""
                    {
                        if (link.assetDescrip?.contains("@img:"))!
                        {
                            let vidComboArray = link.assetDescrip?.components(separatedBy: "@img:")
                            guard let vidURLString = vidComboArray?[1] else { return }
                            print(vidURLString)
                            custVid.imageURLString = vidURLString
                            // YES WORKING!!
                        }
                    }
                    
                    if custVid.determineIfVid() {
                        custVid.m3u8file = link.assetURL
                    }
                    tvVideos?.append(custVid)
                    
                }
            }
        }
        
        
        
        //  configureView()
        
        
        //        UIView.animate(withDuration: 1.0, animations: {
        //            self.coverView.alpha = 0
        //            self.view.layoutIfNeeded()
        //        })
        // loadingIndicator.stopAnimating()
        setUpScreen()
        
        resourcesCollection.reloadData()
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.5) {
            self.resourcesLabel.alpha = 1
            self.scrollTextLabel.alpha = 1
            self.sectionLabel.alpha = 1
            self.goLeftButton.alpha = 1
            self.goRightButton.alpha = 1
            self.upButton.alpha = 1
            self.downButton.alpha = 1
            
            self.coverView.alpha = 0
        }
        
        
    }
    
    func gotTheConfigSettings(_ theSettings: [SeriesItem]) {
        /*
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
         
         */
    }
    
    
}
