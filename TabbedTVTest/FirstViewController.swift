//
//  FirstViewController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 5/9/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//
// WORKING VERSION JUNE 1st !!!!

import UIKit
import AVKit
import SDWebImage

protocol APIControllerProtocol
{
    func gotTheVideos(withOrder value: String, theVideos: [Video])
}

var videoIDAlbumNumber = "3730564"
var videoID2AlbumNumber = "3816976"
var videoID3AlbumNumber = "3446210"

let vimeoURLOpening = "/users/northlandchurch/albums/"
//let vimeoURLSettings = "/videos?per_page=15"

  //fileprivate var focusGuide = UIFocusGuide()


class FirstViewController: UIViewController, APIControllerProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrayOfVideos = [Video]()
    var nextArrayOfVideos = [Video]()
    
   // var apiDataToQuery = vimeoURLOpening + videoIDAlbumNumber + vimeoURLSettings
    var theseVideosString = "/users/northlandchurch/albums/\(videoIDAlbumNumber)/videos?per_page=15"
    var theNextVideoString = "/users/northlandchurch/albums/\(videoID2AlbumNumber)/videos?per_page=15"
    
    
    
    let defaultsTV = UserDefaults.standard
    var todayCheck: Date?
    var stamperFormat = DateFormatter()
    var stamper = ""
    var perPage = 15
    var incrementer = 1
    var hasDisplayedOnce = false
    
    
    
    var anApiController: APIController!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var servicesImageView1: UIImageView!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var bottomTextView: UITextView!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    @IBOutlet weak var scrollTextLabel: UILabel!

    
    @IBOutlet weak var collection1: UICollectionView!
    
    @IBOutlet weak var helperButton: UIButton!
    
    
    var scrollPosX = 0
    var scollPosY = 0
    var scrollPosition = CGPoint(x: 0, y: 0)
    var downTimer = Timer()
    
    let focusGuide = UIFocusGuide()
    var prefEnvironments: [UIFocusEnvironment] = []
    


    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        anApiController = APIController(delegate: self)
        anApiController.getVideoFullServicesDataFromVimeo(theseVideosString)
       // anApiController.getVideoSermonsDataFromVimeo(theNextVideoString)
        
        let longPressGestureRecognizer1 = UILongPressGestureRecognizer(target: self, action: #selector(longPressDown))
        let longPressGestureRecognizer2 = UILongPressGestureRecognizer(target: self, action: #selector(longPressUp))
        
        downButton.addGestureRecognizer(longPressGestureRecognizer1)
        upButton.addGestureRecognizer(longPressGestureRecognizer2)
        
        todayCheck = Date()
        setUpHelperFocus()
       

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dateTV_get = defaultsTV.object(forKey: "DateFullServices") as? Date ?? todayCheck
        let result = Int(todayCheck!.timeIntervalSince(dateTV_get!))
         print("Last FullServices check was: \(result)")
        if result > 43200
        {
            reloadFromAPI() // **********  Fresh call to api!! ******************
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        defaultsTV.set(todayCheck, forKey: "DateFullServices")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.previouslyFocusedView == downButton
        {
            focusGuide.preferredFocusEnvironments = [collection1]
        }
        if context.previouslyFocusedView != downButton
        {
            focusGuide.preferredFocusEnvironments = [downButton]
        }
    }
    
    func setUpHelperFocus() {
       // focusGuide.preferredFocusEnvironments = [downButton]
        self.view.addLayoutGuide(focusGuide)
        focusGuide.leftAnchor.constraint(equalTo: helperButton.leftAnchor, constant: 0).isActive = true
        focusGuide.rightAnchor.constraint(equalTo: helperButton.rightAnchor, constant: 0).isActive = true
        focusGuide.topAnchor.constraint(equalTo: helperButton.topAnchor, constant: 0).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: helperButton.bottomAnchor, constant: 0).isActive = true
    }
    
    func reloadFromAPI() {
        resetIncrementer()
        theseVideosString = "/users/northlandchurch/albums/3446210/videos?per_page=\(perPage)"
        
        anApiController.syncTheVideos(arrayOfVideos)
        anApiController.purgeVideosFromArray()
        anApiController.getVideoFullServicesDataFromVimeo(theseVideosString)
        

    }
    
    func resetIncrementer() {
        incrementer = 1
        switch videoIDAlbumNumber
        {
        case "3446209":
            theseVideosString = "/users/northlandchurch/albums/\(videoIDAlbumNumber)/videos?page=\(incrementer)&per_page=15&sort=alphabetical"
        case "3742438":
            theseVideosString = "/users/northlandchurch/albums/\(videoIDAlbumNumber)/videos?page=\(incrementer)&per_page=15&sort=alphabetical"
        default:
            theseVideosString = "/users/northlandchurch/albums/\(videoIDAlbumNumber)/videos?page=\(incrementer)&per_page=15"
        }

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
        downTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(downTimerAction1), userInfo: nil, repeats: true)
    }
    
    func startTimerButtonUpTapped() {
        downTimer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        downTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(upTimerAction1), userInfo: nil, repeats: true)
    }
    
    // called every time interval from the timer
    func downTimerAction1() {
        print("down")
        if bottomTextView.contentOffset.y <= ((bottomTextView.contentSize.height - bottomTextView.frame.size.height) - 20) {
            scrollPosition.y = scrollPosition.y + 20
            bottomTextView.setContentOffset(scrollPosition, animated: true)
        }
        else {
            downTimer.invalidate()
            print("timer stopped")
        }
        
    }
    
    func upTimerAction1() {
        print("down")
        if bottomTextView.contentOffset.y >= (20) {
            scrollPosition.y = scrollPosition.y - 20
            bottomTextView.setContentOffset(scrollPosition, animated: true)
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
            bottomTextView.setContentOffset(scrollPosition, animated: true)
        }
    }
    
    @IBAction func scrollDownTapped(_ sender: UIButton) {
        
        if bottomTextView.contentOffset.y <= ((bottomTextView.contentSize.height - bottomTextView.frame.size.height) - 20) {
            scrollPosition.y = scrollPosition.y + 20
            bottomTextView.setContentOffset(scrollPosition, animated: true)
        }
        
    }


    
    func resetBG(with aVid: Video) {
        let title = aVid.name
        let moreInfo = aVid.descript
        self.topLabel.text = title
        self.bottomTextView.text = moreInfo
        let myURL2 = URL(string: aVid.imageURLString!)
        let placeHolder = UIImage(named: "WhiteBack.png")
        self.servicesImageView1.sd_setImage(with: myURL2, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
        
    }
    
    

    
   
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        //        if collectionView == collection1
        //        {
        //            return 1
        //        }
        //        if collectionView == collection2
        //        {
        //            return 1
        //        }
        //        else
        //        {
        //            return 0
        //        }
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //return mediaItems.count
        
             return arrayOfVideos.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myCell = UICollectionViewCell()
        
        // Configure the cell
        if collectionView == collection1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! FirstCollectionViewCell
            
            
            let aVid = arrayOfVideos[indexPath.row]
            cell.firstLabel.text = ""
            
            let placeHolder = UIImage(named: "WhiteBack.png")
            //let myURL = aVid.imageURLString!
            let realURL = URL(string: aVid.imageURLString!)
            
            cell.firstImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
            
            if indexPath.row == arrayOfVideos.count - 1
            {
                incrementer = incrementer + 1
                loadMoreAutoRetrieve()
            }

        
            return cell
            
        }
        else
        {
            return myCell
            
        }
        
        
    }
    
    func loadMoreAutoRetrieve()
    {
        // incrementer = incrementer + 1
        switch videoIDAlbumNumber
        {
        case "3446209":
            theseVideosString = "/users/northlandchurch/albums/\(videoIDAlbumNumber)/videos?page=\(incrementer)&per_page=15&sort=alphabetical"
        case "3742438":
            theseVideosString = "/users/northlandchurch/albums/\(videoIDAlbumNumber)/videos?page=\(incrementer)&per_page=15&sort=alphabetical"
        default:
            theseVideosString = "/users/northlandchurch/albums/\(videoIDAlbumNumber)/videos?page=\(incrementer)&per_page=15"
        }
        anApiController.getVideoFullServicesDataFromVimeo(theseVideosString)
        //collectionView?.reloadData()
    }
       

    
    func gotTheVideos(withOrder value: String, theVideos: [Video])
    {
        if value == "a"
        {
            arrayOfVideos = theVideos
            collection1?.reloadData()
            if hasDisplayedOnce == false
            {
                resetBG(with: arrayOfVideos[0])
 
            }
            upButton.alpha = 1
            downButton.alpha = 1
            scrollTextLabel.alpha = 1
            
            collection1.setNeedsFocusUpdate()
            collection1.updateFocusIfNeeded()
            hasDisplayedOnce = true
            
            // *********************** Setting Background Image ********************************
            
            // See extension in LiveViewController.swift
            
            // *********************** Setting Background Image ********************************
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let cell = context.nextFocusedView as? FirstCollectionViewCell {
            let indexPath: IndexPath? = self.collection1.indexPath(for: cell)
            let aVid = arrayOfVideos[(indexPath!.row)]
            cell.firstLabel.text = aVid.name
            upButton.alpha = 0
            downButton.alpha = 0
            scrollTextLabel.alpha = 0
            
            
            
            coordinator.addCoordinatedAnimations({
                let duration : TimeInterval = UIView.inheritedAnimationDuration;
                UIView.animate(withDuration: (1.0 * duration), delay: 0.0, options: UIViewAnimationOptions.overrideInheritedDuration, animations: {
                    //add your animations
                    let title = aVid.name
                    let moreInfo = aVid.descript
                    //                        self.fadeInLabelsWithFadeTime(using: [self.topLabel, self.bottomLabel], fadeTime: 1.0)
                    self.topLabel.text = title
                    self.bottomTextView.text = moreInfo
//                    self.upButton.alpha = 1
//                    self.downButton.alpha = 1
//                    self.scrollTextLabel.alpha = 1
                    
                    
                    //self.loadPic(with: aVid.imageURLString!, imageView: self.servicesImageView1)
                    self.loadPicWithFadeTime(with: aVid.imageURLString!, imageView: self.servicesImageView1, fadeTime: 1.0)
                    self.downTimer.invalidate()
                    
                }, completion: nil)
                /*
                 completion: { (true) in
                 UIView.animate(withDuration: (1.0 * duration), animations: {
                 self.upButton.alpha = 1
                 self.downButton.alpha = 1
                 self.scrollTextLabel.alpha = 1
                 
                 })
                 }
                 */
            }, completion: { (true) in
                UIView.animate(withDuration: 1.0, animations: {
                    self.upButton.alpha = 1
                    self.downButton.alpha = 1
                    self.scrollTextLabel.alpha = 1
                    
                })
            })
        }
        
        if let cell = context.previouslyFocusedView as? FirstCollectionViewCell {
           // let indexPath: IndexPath? = self.collection1.indexPath(for: cell)
            //let aVid = arrayOfVideos[(indexPath!.row)]
            cell.firstLabel.text = ""

        }
    }
    
    
    /*
    func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let cell = context.nextFocusedView as? FirstCollectionViewCell {
            let indexPath: IndexPath? = self.collection1.indexPath(for: cell)
           // mainImageView.image = UIImage(named: images[indexPath!.row])
        }
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let aVid = arrayOfVideos[indexPath.row]
        let videoURL = URL(string: aVid.m3u8file!)
        
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
    }
    

    



}

