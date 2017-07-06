//
//  Video.swift
//  StaffPics
//
//  Created by Austin Williams on 9/12/15.
//  Copyright (c) 2015 Austin Willimas. All rights reserved.
//

import Foundation
import UIKit
//import RealmSwift

class Video {
    
    
    var uri: String? = ""
    var name: String? = ""
    var duration: String?
    var imageURLString: String? = ""
    var descript: String? = ""
    var videoLink: String? = ""
    var videoURL: String? = ""
    var fileURLString: String? = ""
    var m3u8file: String? = ""
    var isDownloading: Bool = false
    var showingTheDownload: Bool = false
    var isNowPlaying: Bool = false
    var tagForAudioRef: String? = ""
    var totalResults: Int = 1
    var id: Int = 1
    var sortOrder: Int = 1
    
    init(dictionary: [String: AnyObject]) {
        
        self.uri = dictionary["uri"] as? String
        // print(uri)
        
        self.name = dictionary["name"] as? String
       // print(name)
        self.videoLink = dictionary["link"] as? String
        
        self.descript = dictionary["description"] as? String
        
        //TODO optimize image selection process
        
        if dictionary["picturesRlm"] != nil
        {
            self.imageURLString = dictionary["picturesRlm"] as? String
        }
        else
        {
            let pictures = dictionary["pictures"] as? [String: AnyObject]
            
            if let constPictures = pictures
            {
                let sizes = constPictures["sizes"] as? [[String: AnyObject]]
                //  print(sizes![4])
                if let constSizes = sizes
                    
                {
                    if constSizes.count > 0
                    {
                        let redux = constSizes.count - (constSizes.count - 4)
                        
                        let selectedSize = constSizes[redux]
                        self.imageURLString = selectedSize["link"] as? String
                    }
                }
                
            }
        }
        
        //USING TAGS for mp3 podcast reference
        
        if dictionary["tagsRlm"] != nil
        {
            self.tagForAudioRef = dictionary["tagsRlm"] as? String
        }
        else
        {
            let tags = dictionary["tags"] as? [[String: AnyObject]]
            
            if let lastTag = tags?.last
            {
                self.tagForAudioRef = lastTag["name"] as? String
                
            }
        }

        //FILES are the actual m3u8 video file reference
        
        if dictionary["filesRlm"] != nil
        {
            self.m3u8file = dictionary["filesRlm"] as? String
        }
        else
        {
            let files = dictionary["files"] as? [[String: AnyObject]]
            if let hlsFiles = files?.last
            {
                let m3u8FILE = hlsFiles["link_secure"]
                self.m3u8file = m3u8FILE as? String
            }
        }


    }
    
    func convertToURINumber(_ uriString: String) -> Int
    {
        let arrayFromURI = uriString.components(separatedBy: "/")
        if let uriInt = Int((arrayFromURI.last)!)
        {
            return uriInt
        }
        
        return Int(arc4random_uniform(99999))
    }
    
    
//    static func makeVideoFromRlmObjct(_ videoOnDisk: VideoServiceRlm) -> Video?
//    {
//        
//        if let convertDict: [String: AnyObject] = ["uri": videoOnDisk.uri! as AnyObject,
//                                                   "name": videoOnDisk.name! as AnyObject,
//                                                   "link": videoOnDisk.videoLink! as AnyObject,
//                                                   "description": videoOnDisk.descript! as AnyObject,
//                                                   "picturesRlm": videoOnDisk.imageURLString! as AnyObject,
//                                                   "tagsRlm": videoOnDisk.tagForAudioRef! as AnyObject,
//                                                   "filesRlm": videoOnDisk.m3u8file! as AnyObject]
//        {
//            
//            let aVideo = Video(dictionary: convertDict)
//            aVideo.isDownloading = videoOnDisk.isDownloading
//            aVideo.isNowPlaying = videoOnDisk.isNowPlaying
//            aVideo.showingTheDownload = videoOnDisk.showingTheDownload
//            aVideo.id = videoOnDisk.id
//            aVideo.sortOrder = videoOnDisk.sortOrder
//            
//            return aVideo
//        }
//        else
//        {
//            return nil
//        }
//    }
//    
//    static func makeAudioFromRlmObjct(_ videoOnDisk: SermonAudioRlm) -> Video?
//    {
//        
//        if let convertDict: [String: AnyObject] = ["uri": videoOnDisk.uri! as AnyObject,
//                                                   "name": videoOnDisk.name! as AnyObject,
//                                                   "link": videoOnDisk.videoLink! as AnyObject,
//                                                   "description": videoOnDisk.descript! as AnyObject,
//                                                   "picturesRlm": videoOnDisk.imageURLString! as AnyObject,
//                                                   "tagsRlm": videoOnDisk.tagForAudioRef! as AnyObject,
//                                                   "filesRlm": videoOnDisk.m3u8file! as AnyObject]
//        {
//            
//            let aVideo = Video(dictionary: convertDict)
//            aVideo.isDownloading = videoOnDisk.isDownloading
//            aVideo.isNowPlaying = videoOnDisk.isNowPlaying
//            aVideo.showingTheDownload = videoOnDisk.showingTheDownload
//            aVideo.id = videoOnDisk.id
//            aVideo.sortOrder = videoOnDisk.sortOrder
//            
//            return aVideo
//        }
//        else
//        {
//            return nil
//        }
//    }
//    
//    static func makeDownloadAudioFromRlmObjct(_ videoOnDisk: DownloadAudioRlm) -> Video?
//    {
//        
//        if let convertDict: [String: AnyObject] = ["uri": videoOnDisk.uri! as AnyObject,
//                                                   "name": videoOnDisk.name! as AnyObject,
//                                                   "link": videoOnDisk.videoLink! as AnyObject,
//                                                   "description": videoOnDisk.descript! as AnyObject,
//                                                   "picturesRlm": videoOnDisk.imageURLString! as AnyObject,
//                                                   "tagsRlm": videoOnDisk.tagForAudioRef! as AnyObject,
//                                                   "filesRlm": videoOnDisk.m3u8file! as AnyObject]
//        {
//            
//            let aVideo = Video(dictionary: convertDict)
//            aVideo.isDownloading = videoOnDisk.isDownloading
//            aVideo.isNowPlaying = videoOnDisk.isNowPlaying
//            aVideo.showingTheDownload = videoOnDisk.showingTheDownload
//            aVideo.id = videoOnDisk.id
//            aVideo.sortOrder = videoOnDisk.sortOrder
//            
//            return aVideo
//        }
//        else
//        {
//            return nil
//        }
//    }



    
    
}

