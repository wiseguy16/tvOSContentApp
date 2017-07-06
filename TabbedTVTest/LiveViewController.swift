//
//  LiveViewController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 5/18/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit
import AVKit
import SDWebImage

class LiveViewController: UIViewController {
    
    @IBOutlet weak var liveLabel1: UILabel!
    
    @IBOutlet weak var liveLabel2: UILabel!
    
    
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var liveImageView1: UIImageView!
    
    let liveImageString = "https://i.vimeocdn.com/video/543765889_1280x719.jpg?r=pad"
    //  https://i.vimeocdn.com/video/543765889_1280x719.jpg?r=pad
    //   let liveImageString = "https://i.vimeocdn.com/video/635212073_1280x720.jpg?r=pad"  https://www.northlandchurch.net/_assets/img/v2/series/Globe-map_tvOS.jpg
    
//    let bgString = "https://www.globeatnight.org/images/Globe-at-Night-Map2013-lg.jpg"
        let bgString = "https://www.northlandchurch.net/_assets/img/v2/series/Globe-map_tvOS.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
       // let barColor = UIColor(red: 49/255, green: 75/255, blue: 108/255, alpha: 1.0)
//        let barColor = UIColor.black
//        let pressedTintColor = hexStringToUIColor("#aaaaaa")
        
       // UITabBar.appearance().barTintColor = barColor
       // UITabBar.appearance().tintColor = pressedTintColor
//        self.view.backgroundColor = hexStringToUIColor("#222222")
       // UITabBar.appearance()

        
        addBlur(onImage: bgImage)
       // bgImage.alpha = 0
       

        setBGView()
        loadPic(with: liveImageString, imageView: liveImageView1)

        liveLabel1.text = "Join us for Live Worship!"
        liveLabel2.text = "Northland worships God for who He is and what He has done for us. \nYou and your group can connect to God's community during one of our Live worship times (EST). \n\nSaturdays at 5pm \n\nSundays at 9am & 11am \n\nMondays at 7pm"

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //bgImage.alpha = 0
       // self.view.backgroundColor = hexStringToUIColor("#222222")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBGView() {
       // bgImage.sd
        let placeHolder = UIImage(named: "WhiteBack.png")
        //let myURL = aVid.imageURLString!
        let realURL = URL(string: liveImageString)
        
        bgImage.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
        

        // *********************** Setting Background Image ********************************
        loadPicWithFadeTime(with: bgString, imageView: bgImage, fadeTime: 1.5)
        
        
        // *********************** Setting Background Image ********************************
        

        
    
  }
    
    @IBAction func goToLiveService(_ sender: UIButton) {
        
        playLiveService()
    }
    
    
    func playLiveService() {
        let videoURL = URL(string: "http://WtIDGlE-lh.akamaihd.net/i/northlandlive_1@188060/master.m3u8")
        
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
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
    
    
    /*
     UIView.animate(withDuration: 12.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
     self.YOURLABEL.center = CGPoint(x: 0 - self.YOURLABEL.bounds.size.width / 2, y: self.YOURLABEL.center.y)
     }, completion:  { _ in })
     */

}

extension UILabel {
    func makeTextAutoScroll(on yourLabel: UILabel) {
        UIView.animate(withDuration: 12.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
            yourLabel.center = CGPoint(x: 0 - yourLabel.bounds.size.width / 2, y: yourLabel.center.y)
        }, completion:  { _ in })

        
    }
    
}

extension UIViewController {
    func loadPic(with imageStringURL: String, imageView: UIImageView) {
        let myURL = URL(string: imageStringURL)
        URLSession.shared.dataTask(with: myURL!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "err")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                imageView.image = image
            })
            
        }).resume()
        
    }
    
    func loadPicWithFadeTime(with imageStringURL: String, imageView: UIImageView, fadeTime: TimeInterval) {
        let myURL = URL(string: imageStringURL)
         imageView.alpha = 0
        URLSession.shared.dataTask(with: myURL!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "err")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                UIView.animate(withDuration: fadeTime, animations: {
                    imageView.image = image
                    imageView.alpha = 1
                })
                
            })
            
        }).resume()
        
    }
    
    func fadeInLabelsWithFadeTime(using arrayOfLabels: [UILabel], fadeTime: TimeInterval) {
        for label in arrayOfLabels {
            label.alpha = 0
            UIView.animate(withDuration: fadeTime, animations: {
                label.alpha = 1
            })

        }

    }
    
    // *********************** Setting Background Image ********************************

    func addBlur(onImage bgView: UIImageView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bgView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgView.addSubview(blurEffectView)

        
    }
    


    
}
