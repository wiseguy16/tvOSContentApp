//
//  TVCustomVideo.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 6/2/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import Foundation
import UIKit



class TVCustomVideo {
    
    var name: String? = ""
    var imageURLString: String? = ""
    var m3u8file: String? = ""
    var isVideo: Bool = false
    var isPic: Bool = true
    
    init(name: String?, imageURLString: String?) {
        self.name = name
        self.imageURLString = imageURLString
        
    }
    
    func determineIfVid() -> Bool {
        guard let scanWord = name else { return false }
        let check1 = scanWord.contains("Video")
        let check2 = scanWord.contains("video")
        let check3 = scanWord.contains("VIDEO")
        
        if check1 || check2 || check3
        {
            isPic = false
            return true
        }
        else
        {
            return false
        }
    }

}
