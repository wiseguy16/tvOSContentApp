//
//  FourthViewController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 6/15/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import AVKit
import SDWebImage




class FourthViewController: UIViewController, APIControllerProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrayOfVideos = [Video]()
    var nextArrayOfVideos = [Video]()
    
   // var apiDataToQuery = vimeoURLOpening + videoIDAlbumNumber + vimeoURLSettings
    var theseVideosString = "/users/northlandchurch/albums/\(videoIDAlbumNumber)/videos?per_page=15"
    var theNextVideoString = "/users/northlandchurch/albums/\(videoID3AlbumNumber)/videos?per_page=15"
    
    let defaultsTV = UserDefaults.standard
    var todayCheck: Date?
    var stamperFormat = DateFormatter()
    var stamper = ""
    var perPage = 15
    var incrementer = 1
    var hasDisplayedOnce = false

    
    var anApiController: APIController!
    
    
    
    @IBOutlet weak var collection2: UICollectionView!
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    @IBOutlet weak var focusImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anApiController = APIController(delegate: self)
        anApiController.getVideoSermonsDataFromVimeo(theNextVideoString)
        
        todayCheck = Date()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dateTV_get = defaultsTV.object(forKey: "DateSermons") as? Date ?? todayCheck
        let result = Int(todayCheck!.timeIntervalSince(dateTV_get!))
        print("Last FullServices check was: \(result)")
        if result > 43200
        {
            reloadFromAPI() // **********  Fresh call to api!! ******************
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        defaultsTV.set(todayCheck, forKey: "DateSermons")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadFromAPI() {
        resetIncrementer()
        theNextVideoString = "/users/northlandchurch/albums/\(videoID3AlbumNumber)/videos?per_page=\(perPage)"
        
        anApiController.syncTheSermons(arrayOfVideos)
        anApiController.purgeSermons()
        anApiController.getVideoSermonsDataFromVimeo(theNextVideoString)
        
        
    }
    
    func resetIncrementer() {
        incrementer = 1
        switch videoID3AlbumNumber
        {
//        case "3446209":
//            theNextVideoString = "/users/northlandchurch/albums/\(videoID3AlbumNumber)/videos?page=\(incrementer)&per_page=15&sort=alphabetical"
//        case "3742438":
//            theNextVideoString = "/users/northlandchurch/albums/\(videoID3AlbumNumber)/videos?page=\(incrementer)&per_page=15&sort=alphabetical"
        default:
            theNextVideoString = "/users/northlandchurch/albums/\(videoID3AlbumNumber)/videos?page=\(incrementer)&per_page=15"
        }
        
    }

    
    func resetBG(with aVid: Video) {
        let title = aVid.name
        let moreInfo = aVid.descript
        self.topLabel.text = title
        self.bottomLabel.text = moreInfo
        let myURL2 = URL(string: aVid.imageURLString!)
        let placeHolder = UIImage(named: "WhiteBack.png")
        self.focusImageView.sd_setImage(with: myURL2, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
        
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
        
        return nextArrayOfVideos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let myCell = UICollectionViewCell()
        
        // Configure the cell
        if collectionView == collection2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCollectionViewCell", for: indexPath) as! FourthCollectionViewCell
            
            let aVid = nextArrayOfVideos[indexPath.row]
            cell.fourthTitleLabel.text = ""
            
            let placeHolder = UIImage(named: "WhiteBack.png")
            let myURL = aVid.imageURLString!
            let realURL = URL(string: myURL)
            
            cell.fourthImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
            
            if indexPath.row == nextArrayOfVideos.count - 1
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
        switch videoID3AlbumNumber
        {
//        case "3446209":
//            theseVideosString = "/users/northlandchurch/albums/\(videoID3AlbumNumber)/videos?page=\(incrementer)&per_page=15&sort=alphabetical"
//        case "3742438":
//            theseVideosString = "/users/northlandchurch/albums/\(videoID3AlbumNumber)/videos?page=\(incrementer)&per_page=15&sort=alphabetical"
        default:
            theNextVideoString = "/users/northlandchurch/albums/\(videoID3AlbumNumber)/videos?page=\(incrementer)&per_page=15"
        }
        anApiController.getVideoSermonsDataFromVimeo(theNextVideoString)
        //collectionView?.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let cell = context.nextFocusedView as? FourthCollectionViewCell {
            let indexPath: IndexPath? = self.collection2.indexPath(for: cell)
            let aVid = nextArrayOfVideos[(indexPath!.row)]
            cell.fourthTitleLabel.text = aVid.name
            
            
            coordinator.addCoordinatedAnimations({
                let duration : TimeInterval = UIView.inheritedAnimationDuration
                UIView.animate(withDuration: (1.0 * duration), delay: 0.0, options: UIViewAnimationOptions.overrideInheritedDuration, animations: {
                    //add your animations
                    let title = aVid.name
                    let moreInfo = aVid.descript
                    self.topLabel.text = title
                    self.bottomLabel.text = moreInfo
                    
                    let myURL2 = URL(string: aVid.imageURLString!)
                    
                    URLSession.shared.dataTask(with: myURL2!, completionHandler: { (data, response, error) -> Void in
                        if error != nil {
                            print(error ?? "err")
                            return
                        }
                        DispatchQueue.main.async(execute: { () -> Void in
                            let image = UIImage(data: data!)
                            self.focusImageView.image = image
                        })
                        
                    }).resume()
                    
                    
                }, completion: nil)
            }, completion: nil)
        }
        
        if let cell = context.previouslyFocusedView as? FourthCollectionViewCell {
            cell.fourthTitleLabel.text = ""
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let aVid = nextArrayOfVideos[indexPath.row]
        let videoURL = URL(string: aVid.m3u8file!)
        
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
    }
    
    
    func gotTheVideos(withOrder value: String, theVideos: [Video])
    {
        if value == "b"
        {
            nextArrayOfVideos = theVideos
            collection2.reloadData()
            if hasDisplayedOnce == false
            {
                resetBG(with: nextArrayOfVideos[0])
            }
            collection2.setNeedsFocusUpdate()
            collection2.updateFocusIfNeeded()
            hasDisplayedOnce = true

            
        }
    }
    
    
    
    
    
}

