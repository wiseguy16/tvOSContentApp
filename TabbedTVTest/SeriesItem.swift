//
//  SeriesItem.swift
//  NacdFeatured
//
//  Created by Gregory Weiss on 1/3/17.
//  Copyright © 2017 NorthlandChurch. All rights reserved.
//

import Foundation
import UIKit
//import RealmSwift

class SeriesItem
{
    var entry_id: Int? = 1
    var channel: String? = ""
    var title: String? = ""
    var urltitle: String? = ""
    var entry_date: String? = ""
    
    var studyGuideBGColor: String? = ""
    var studyImage: String? = ""
    var author: String? = ""
    var currentWeek: Int? = 1
    var studyWeekCount: Int? = 0
    
    var studySessions: [StudySession]? = []
    var studyAssets: [StudyAsset]? = []
    var studyColors: [StudyColorGuide]? = []
    var sessionSections: [SessionSection]? = []
    
    
    
    var uri: String? = ""
    var mediaFileM3U8: String? = ""
    var videoSessionImage: String? = ""
    var webURL: String? = ""
    var body: String? = ""
    var closingText: String? = ""
    var session_devotionals: String? = ""
    var session_introduction: String? = ""
    var session_share: String? = ""
    var session_hear: String? = ""
    var session_create: String? = ""
    var session_digging_deeper: String? = ""
    var session_memory_verse: String? = ""
    var session_memory_verse_ref: String? = ""
    
    var session_devotional1: String? = ""
    var session_devotional1_scripRef: String? = ""
    var session_devotional1_scripture: String? = ""
    var session_devotional1_reflect: String? = ""
    
    var session_devotional2: String? = ""
    var session_devotional2_scripRef: String? = ""
    var session_devotional2_scripture: String? = ""
    var session_devotional2_reflect: String? = ""
    
    var session_devotional3: String? = ""
    var session_devotional3_scripRef: String? = ""
    var session_devotional3_scripture: String? = ""
    var session_devotional3_reflect: String? = ""
    
    var session_devotional4: String? = ""
    var session_devotional4_scripRef: String? = ""
    var session_devotional4_scripture: String? = ""
    var session_devotional4_reflect: String? = ""
    
    var session_devotional5: String? = ""
    var session_devotional5_scripRef: String? = ""
    var session_devotional5_scripture: String? = ""
    var session_devotional5_reflect: String? = ""
    
    var session_devotional6: String? = ""
    var session_devotional6_scripRef: String? = ""
    var session_devotional6_scripture: String? = ""
    var session_devotional6_reflect: String? = ""
    
    var trailerVideo: String? = ""
    var trailerImage: String? = ""
    var trailerTitle: String? = ""
    var sectionDividerColor: String? = ""
    var devoDividerColor: String? = ""
    var headlineTextColor: String? = ""
    var subHeadlineTextColor: String? = ""
    var bodyTextColor: String? = ""
    var arrowColor: String? = ""
    var topBgViewColor: String? = ""
    var midBgViewColor: String? = ""
    var bodyBgViewColor: String? = ""
    var mainTitleTextColor: String? = ""
    var authorTextColor: String? = ""
    
    
    
    
    init(myDictionary: [String: AnyObject])
    {
        self.uri = myDictionary["uri"] as? String
        self.channel = myDictionary["channel"] as? String
        self.title = myDictionary["title"] as? String
        self.urltitle = myDictionary["urltitle"] as? String
        self.entry_date = myDictionary["entry_date"] as? String
        self.mediaFileM3U8 = myDictionary["session-vimeo-path-m3u8"] as? String
        self.videoSessionImage = myDictionary["session-vimeo-preview-image"] as? String
        self.trailerVideo = myDictionary["study-guide-vimeo-path-m3u8"] as? String
        self.trailerImage = myDictionary["study-guide-vimeo-preview-image"] as? String
        self.trailerTitle = myDictionary["study-guide-vimeo-trailer-title"] as? String
        
        
        self.studyImage = myDictionary["study-guide-image"] as? String
        self.currentWeek = myDictionary["study-week-current"] as? Int
        self.studyWeekCount = myDictionary["study-week-count"] as? Int
        self.author = myDictionary["study-guide-author"] as? String
        self.studyGuideBGColor = myDictionary["study-guide-bg-color"] as? String
        
        self.webURL = myDictionary["webURL"] as? String
        self.body = myDictionary["body"] as? String
        self.closingText = myDictionary["closingText"] as? String
        self.entry_id = myDictionary["entry_id"] as? Int
        self.session_devotionals = myDictionary["session-devotionals"] as? String
        self.session_introduction = myDictionary["session-introduction"] as? String
        self.session_share = myDictionary["session-share"] as? String
        self.session_hear = myDictionary["session-hear"] as? String
        self.session_create = myDictionary["session-create"] as? String
        self.session_digging_deeper = myDictionary["session-digging-deeper"] as? String
        self.session_memory_verse = myDictionary["session-memory-verse"] as? String
        self.session_memory_verse_ref = myDictionary["session-memory-verse-ref"] as? String
        
        self.session_devotional1 = myDictionary["session-devotional1-reflection"] as? String
        self.session_devotional1_scripRef = myDictionary["session-devotional1-scripture-ref"] as? String
        self.session_devotional1_scripture = myDictionary["session-devotional1-scripture"] as? String
        self.session_devotional1_reflect = myDictionary["session-devotional1-reflection"] as? String
        
        self.session_devotional2 = myDictionary["session-devotional2-reflection"] as? String
        self.session_devotional2_scripRef = myDictionary["session-devotional2-scripture-ref"] as? String
        self.session_devotional2_scripture = myDictionary["session-devotional2-scripture"] as? String
        self.session_devotional2_reflect = myDictionary["session-devotional2-reflection"] as? String
        
        self.session_devotional3 = myDictionary["session-devotional3-reflection"] as? String
        self.session_devotional3_scripRef = myDictionary["session-devotional3-scripture-ref"] as? String
        self.session_devotional3_scripture = myDictionary["session-devotional3-scripture"] as? String
        self.session_devotional3_reflect = myDictionary["session-devotional3-reflection"] as? String
        
        
        self.session_devotional4 = myDictionary["session-devotional4-reflection"] as? String
        self.session_devotional4_scripRef = myDictionary["session-devotional4-scripture-ref"] as? String
        self.session_devotional4_scripture = myDictionary["session-devotional4-scripture"] as? String
        self.session_devotional4_reflect = myDictionary["session-devotional4-reflection"] as? String
        
        self.session_devotional5 = myDictionary["session-devotional5-reflection"] as? String
        self.session_devotional5_scripRef = myDictionary["session-devotional5-scripture-ref"] as? String
        self.session_devotional5_scripture = myDictionary["session-devotional5-scripture"] as? String
        self.session_devotional5_reflect = myDictionary["session-devotional5-reflection"] as? String
        
        self.session_devotional6 = myDictionary["session-devotional6-reflection"] as? String
        self.session_devotional6_scripRef = myDictionary["session-devotional6-scripture-ref"] as? String
        self.session_devotional6_scripture = myDictionary["session-devotional6-scripture"] as? String
        self.session_devotional6_reflect = myDictionary["session-devotional6-reflection"] as? String
        
        self.sectionDividerColor = myDictionary["study-guide-section-divider-color"] as? String
        self.devoDividerColor = myDictionary["study-guide-devotional-divider-color"] as? String
        self.headlineTextColor = myDictionary["study-guide-headline-text-color"] as? String
        self.subHeadlineTextColor = myDictionary["study-guide-subheadline-text-color"] as? String
        self.bodyTextColor = myDictionary["study-guide-body-text-color"] as? String
        self.topBgViewColor = myDictionary["study-guide-topBg-color"] as? String
        self.midBgViewColor = myDictionary["study-guide-midBg-color"] as? String
        self.bodyBgViewColor = myDictionary["study-guide-bodyBg-color"] as? String
        self.arrowColor = myDictionary["study-guide-arrow-color"] as? String
        self.mainTitleTextColor = myDictionary["study-guide-mainTitle-color"] as? String
        self.authorTextColor = myDictionary["study-guide-author-color"] as? String
        
        if myDictionary["study-sessions"] != nil
        {
            let studyArray = myDictionary["study-sessions"] as! [[String: AnyObject]]
            var counter = 1
            for theSessionDict in studyArray
            {
                let studyTitle = theSessionDict["study-week-\(counter)-title"] as! String
                let studyURL = theSessionDict["study-week-\(counter)-url"] as! String
                let aStudy = StudySession()
                aStudy.studyWeekNumber = counter
                aStudy.studyWeekTitle = studyTitle
                aStudy.studyWeekURL = studyURL
                studySessions?.append(aStudy)
                
                counter = counter + 1
            }
            //counter = 1
        }
        
        if myDictionary["session-images"] != nil
        {
            let assetArray = myDictionary["session-images"] as! [[String: AnyObject]]
            for theAssetDict in assetArray
            {
                let astTitle = theAssetDict["session-image-title"] as! String
                let astURL = theAssetDict["session-image-source"] as! String
                let astDescrip = theAssetDict["session-image-description"] as! String
                let astID = theAssetDict["id"] as! Int
                let anAsset = StudyAsset()
                anAsset.assetTitle = astTitle
                anAsset.assetURL = astURL
                anAsset.assetDescrip = astDescrip
                anAsset.assetID = astID
                studyAssets?.append(anAsset)
            }
        }
        
        if myDictionary["color-palette"] != nil
        {
            let colorsArray = myDictionary["color-palette"] as! [[String: AnyObject]]
            for thecolorDict in colorsArray
            {
                let hexColorString = thecolorDict["hex-val"] as! String
                let commonName = thecolorDict["common-name"] as! String
                let colorID = thecolorDict["id"] as! Int
                let aColor = StudyColorGuide()
                aColor.hexColorString = hexColorString
                aColor.commonName = commonName
                aColor.colorID = colorID
                studyColors?.append(aColor)
            }
        }
        
        if myDictionary["session-sections"] != nil
        {
            let sectionsArray = myDictionary["session-sections"] as! [[String: AnyObject]]
            for theSectionDict in sectionsArray
            {
                let id = theSectionDict["id"] as! Int
                var body = ""
                var image = ""
                var source = ""
                var vidTitle = ""
                var btnText = ""
                var btnURL = ""
                
                let headline = theSectionDict["session-section-headline"] as! String
                if theSectionDict["session-section-body"] != nil
                {
                    body = theSectionDict["session-section-body"] as! String
                    
                }
                if theSectionDict["session-section-preview-image"] != nil
                {
                    image = theSectionDict["session-section-preview-image"] as! String
                }
                if theSectionDict["session-section-video-source"] != nil
                {
                    source = theSectionDict["session-section-video-source"] as! String
                }
                if theSectionDict["session-section-video-title"] != nil
                {
                    vidTitle = theSectionDict["session-section-video-title"] as! String
                }
                if theSectionDict["session-section-button-text"] != nil
                {
                    btnText = theSectionDict["session-section-button-text"] as! String
                }
                if theSectionDict["session-section-button-url"] != nil
                {
                    btnURL = theSectionDict["session-section-button-url"] as! String
                }
                
                
                let aSection = SessionSection()
                aSection.sectionID = id
                aSection.sectionHeadline = headline
                aSection.sectionBody = body
                aSection.previewImage = image
                aSection.videoSource = source
                aSection.videoTitle = vidTitle
                aSection.buttonText = btnText
                aSection.buttonURL = btnURL
                sessionSections?.append(aSection)
            }
        }
        
        
        
        
        
    }
    
    
//    func replaceBreakWithReturn(_ brString: String) -> String
//    {
//        var properRetun = brString.replacingOccurrences(of: "<br />    ", with: "\n")
//        properRetun = properRetun.replacingOccurrences(of: "<br />", with: "\n")
//        properRetun = properRetun.replacingOccurrences(of: "<p style='text-align: center;'>", with: "")
//        properRetun = properRetun.replacingOccurrences(of: "<p style='display:none'>", with: "")
//        
//        properRetun = properRetun.replacingOccurrences(of: "<p>", with: "")
//        properRetun = properRetun.replacingOccurrences(of: "</p>", with: "\n \n")
//        properRetun = properRetun.replacingOccurrences(of: "<strong>", with: "")
//        properRetun = properRetun.replacingOccurrences(of: "</strong>", with: "")
//        
//        //properRetun = properRetun.html2String
//        
//        // print(properRetun)
//        
//        
//        return properRetun
//    }
    
    
    
}

extension String {
    func replaceBreakWithReturn(_ brString: String) -> String
    {
        var properRetun = brString.replacingOccurrences(of: "<br />    ", with: "\n")
        properRetun = properRetun.replacingOccurrences(of: "<br />", with: "\n")
        properRetun = properRetun.replacingOccurrences(of: "<p style='text-align: center;'>", with: "")
        properRetun = properRetun.replacingOccurrences(of: "<p style='display:none'>", with: "")
        
        properRetun = properRetun.replacingOccurrences(of: "<p>", with: "")
        properRetun = properRetun.replacingOccurrences(of: "</p>", with: "\n \n")
        properRetun = properRetun.replacingOccurrences(of: "<strong>", with: "")
        properRetun = properRetun.replacingOccurrences(of: "</strong>", with: "")
        
        //properRetun = properRetun.html2String
        
        // print(properRetun)
        
        
        return properRetun
    }

}








