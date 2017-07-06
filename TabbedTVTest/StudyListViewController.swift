//
//  StudyListViewController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 5/18/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//
// WORKING VERSION JUNE 1st !!!!

import UIKit
import SDWebImage

protocol CurrentSeriesAPIControllerProtocol
{
    func gotTheSeries(_ theSeries: [SeriesItem])
    func gotTheConfigSettings(_ theSettings: [SeriesItem])
    
}


class StudyListViewController: UIViewController, CurrentSeriesAPIControllerProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var anApiController: CurrentSeriesAPIController!
    
    var currentSeriesItems = [SeriesItem]()
    var configSettingArray = [SeriesItem]()
    var thisSeries: SeriesItem!
    var seriesConfigSettings: SeriesItem!
    var assetLinks: [StudyAsset]? = []
    
    let baseURLString = "https://www.northlandchurch.net/api/get-all-study-guides/"
    var thisSession = ""
    var weekNumber = "series"
    var currentWeek = "one"
    
    var testInt = 1
    
    
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var bigTitleLabel: UILabel!

    @IBOutlet weak var bigAuthorLabel: UILabel!
    @IBOutlet weak var bigLengthLabel: UILabel!

    
    
    @IBOutlet weak var guidesCollection1: UICollectionView!
    
    var arrayOfStudyGuides = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        anApiController = CurrentSeriesAPIController(delegate: self)
        
        anApiController.getPreviousSeriesConfigurationDataFromNACD()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //return mediaItems.count
        
        return configSettingArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myCell = UICollectionViewCell()
        
        // Configure the cell
        if collectionView == guidesCollection1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudyListCell", for: indexPath) as! StudyListCollectionViewCell
            
            let aStudy = configSettingArray[indexPath.row]
            cell.studyTitleLabel.text = aStudy.title
            cell.studyDescriptionLabel.text = aStudy.author
            
            let placeHolder = UIImage(named: "WhiteBack.png")
            let myURL = aStudy.studyImage
            let realURL = URL(string: myURL!)
            
            cell.studyImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
            
            return cell
            
            
        }
        else
        {
            return myCell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let cell = context.nextFocusedView as? StudyListCollectionViewCell {
            let indexPath: IndexPath? = self.guidesCollection1.indexPath(for: cell)
            let aStudy = configSettingArray[(indexPath!.row)]
            
            
            coordinator.addCoordinatedAnimations({
                let duration : TimeInterval = UIView.inheritedAnimationDuration
                UIView.animate(withDuration: (1.0 * duration), delay: 0.0, options: UIViewAnimationOptions.overrideInheritedDuration, animations: {
                    //add your animations
                    var numberOfWeeks = 0
                    let theTitle = aStudy.title
                    let theAuthor = aStudy.author
                    if let studyLength = aStudy.studySessions?.count
                    {
                        numberOfWeeks = studyLength
                    }
                    let placeHolder = UIImage(named: "WhiteBack.png")
                    let myURL = aStudy.trailerImage
                    let realURL = URL(string: myURL!)
                    self.bigTitleLabel.text = theTitle
                    self.bigAuthorLabel.text = theAuthor
                    self.bigLengthLabel.text = "\(numberOfWeeks) Session Study"
                    self.bigImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
               
                    
                    // Update the image maybe?
                    
                    
                    
                }, completion: nil)
            }, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        let aStudy = configSettingArray[indexPath.row]
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "StudyOverviewViewController") as! StudyOverviewViewController
        detailVC.thisIndividualStudy = aStudy
//        print(aStudy)
        detailVC.thisStudyURL = aStudy.urltitle
        present(detailVC, animated: true, completion: nil)
        
       // navigationController?.pushViewController(detailVC, animated: true)
        
        // detailVC.aBlogItem = aBlog
        //Answers.logCustomEventWithName("Read a Blog", customAttributes: ["Title": aBlog.title!, "URL": aBlog.urltitle!])
        
        
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func resetBG(with anItem: SeriesItem) {
        var numberOfWeeks = 0
        let theTitle = anItem.title
        let theAuthor = anItem.author
        if let studyLength = anItem.studySessions?.count
        {
            numberOfWeeks = studyLength
        }
        let placeHolder = UIImage(named: "WhiteBack.png")
        let myURL = anItem.trailerImage
        let realURL = URL(string: myURL!)
        self.bigTitleLabel.text = theTitle
        self.bigAuthorLabel.text = theAuthor
        self.bigLengthLabel.text = "\(numberOfWeeks) Session Study"
        self.bigImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
    }

}

extension StudyListViewController {
    
    func gotTheSeries(_ theSeries: [SeriesItem]) {
        
        assetLinks?.removeAll()
        currentSeriesItems = theSeries   //theSeries
        thisSeries = currentSeriesItems[0]
        
        
        if currentSeriesItems[0].studyAssets != nil
        {
            if currentSeriesItems[0].studyAssets!.count > 0
            {
                assetLinks = currentSeriesItems[0].studyAssets
            }
        }
        
        
        
        //    configureView()
        
        /*
         UIView.animateWithDuration(1.0) {
         self.coverView.alpha = 0
         self.view.layoutIfNeeded()
         }
         */
      //  loadingIndicator.stopAnimating()
        
        //self.view.setNeedsLayout()
        
        guidesCollection1?.reloadData()
        
        // print("conforming to protocol")

        
    }
    
    
    func gotTheConfigSettings(_ theSettings: [SeriesItem]) {
        
        configSettingArray = theSettings
        //   seriesConfigSettings = configSettingArray[0]
        //   testInt = seriesConfigSettings.currentWeek!
        if configSettingArray[0].studySessions != nil
        {
            if configSettingArray[0].studySessions!.count > 0
            {
                //   sessionPickerButton.userInteractionEnabled = true
            }
            
        }
        
        //self.view.setNeedsLayout()
        
        guidesCollection1?.reloadData()
        let firstSeries = configSettingArray[0]
        resetBG(with: firstSeries)
        guidesCollection1.setNeedsFocusUpdate()
        guidesCollection1.updateFocusIfNeeded()
        

        print(firstSeries.author ?? "nothing here??")
        

        
    }
    
}
