//
//  PicViewController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 6/6/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit
import SDWebImage

class PicViewController: UIViewController {
    
    var imageURLString: String!
    
    @IBOutlet weak var picImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let placeHolder = UIImage(named: "WhiteBack.png")
        let myURL = imageURLString
        let realURL = URL(string: myURL!)
        
        picImageView.sd_setImage(with: realURL, placeholderImage: placeHolder, options: [.progressiveDownload, .refreshCached])
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
