//
//  APIController.swift
//  WordSearchAPI
//
//  Created by Gregory Weiss on 8/30/16.
//  Copyright © 2016 Gregory Weiss. All rights reserved.
//

import Foundation
import UIKit
//import RealmSwift

class APIController
{
    
    init(delegate: APIControllerProtocol)
    {
        self.delegate = delegate
    }
    
    var videoArrayOfServices = [Video]()
    var videoArrayOfSermons = [Video]()
    var videoArrayOfSearches = [Video]()
    var videoArrayOfHighlights = [Video]()
   // var arrayOfFeatured = [Featured]()
    
     var checkArrayAudioRlm = [String]()
    
    var delegate: APIControllerProtocol!
    
    var names = [String]()
    
    let errorDomain = "VimeoClientErrorDomain"
    let baseURLString = "https://api.vimeo.com"

    // url might look like: "https://api.vimeo.com/users/northlandchurch/albums/3730564/videos?per_page=15"
    let authToken = "<YOUR_AUTH_TOKEN>"
    
    
    
    
    
    
    
    func getVideoFullServicesDataFromVimeo(_ theseVideos: String)
    {
        
        let URLString = baseURLString + theseVideos
        let myURL = URL(string: URLString)
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                print("Made a call to Vimeo API for \(theseVideos) ")

                if let httpResponse = response as? HTTPURLResponse
                {
                    if httpResponse.statusCode != 200
                    {
                        print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }
                            
                if let vimeoData = data, let jsonResponse = try? JSONSerialization.jsonObject(with: vimeoData, options: []) as? [String: AnyObject], let myJSON = jsonResponse
                {
                    // here "vimeoData" is the dictionary encoded in JSON data
                    let dataArray = myJSON["data"] as? [[String: AnyObject]]
                    if let constArray = dataArray
                    {
                        for value in constArray
                        {
                            let video = Video(dictionary: value)
                            self.videoArrayOfServices.append(video)
                        }
                        //self.delegate.gotTheVideos(self.videoArrayOfServices)
                        self.delegate.gotTheVideos(withOrder: "a", theVideos: self.videoArrayOfServices)
                    }
                }
                else
                {
                    self.networkAlert()
                }
            })
        })
        task.resume()
        return
    }
    
    func getHighlightsDataFromVimeo(_ theseVideos: String)
    {
        let URLString = baseURLString + theseVideos
        let myURL = URL(string: URLString)
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                print("Made a call to Vimeo API for \(theseVideos) ")
                
                if let httpResponse = response as? HTTPURLResponse
                {
                    if httpResponse.statusCode != 200
                    {
                        print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }
                
                if let vimeoData = data, let jsonResponse = try? JSONSerialization.jsonObject(with: vimeoData, options: []) as? [String: AnyObject], let myJSON = jsonResponse
                {
                    // here "vimeoData" is the dictionary encoded in JSON data
                    let dataArray = myJSON["data"] as? [[String: AnyObject]]
                    if let constArray = dataArray
                    {
                        for value in constArray
                        {
                            let video = Video(dictionary: value)
                            self.videoArrayOfHighlights.append(video)
                        }
                        //self.delegate.gotTheVideos(self.videoArrayOfServices)
                        self.delegate.gotTheVideos(withOrder: "c", theVideos: self.videoArrayOfHighlights)
                    }
                }
                else
                {
                    self.networkAlert()
                }
            })
        })
        task.resume()
        return

    }
    
    func getVideoSermonsDataFromVimeo(_ theseVideos: String)
    {
        
        let URLString = baseURLString + theseVideos
        let myURL = URL(string: URLString)
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("Made a call to Vimeo API for \(theseVideos) ")

            DispatchQueue.main.async(execute: { () -> Void in
                print("Vimeo error: \(error)")
                if let httpResponse = response as? HTTPURLResponse
                {
                    //print(httpResponse)
                    if httpResponse.statusCode != 200
                    {
                        print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }
                
                if let vimeoData = data, let jsonResponse = try? JSONSerialization.jsonObject(with: vimeoData, options: []) as? [String: AnyObject], let myJSON = jsonResponse
                {
                    // here "vimeoData" is the dictionary encoded in JSON data
                    
                    let dataArray = myJSON["data"] as? [[String: AnyObject]]
                    
                    if let constArray = dataArray
                    {
                        for value in constArray
                        {
                            let video = Video(dictionary: value)
                            self.videoArrayOfSermons.append(video)
//                            if !self.checkArrayAudioRlm.contains(video.uri!)
//                            {
//                              self.videoArrayOfSermons.append(video)
//                                print("appended item: \(video.uri)")
//                            }
                            
                        }
                       // self.delegate.gotTheVideos(self.videoArrayOfSermons)
                        self.delegate.gotTheVideos(withOrder: "b", theVideos: self.videoArrayOfSermons)
                        print("passing items: \(self.videoArrayOfSermons.count)")
                    }
                }
                else
                {
                    self.networkAlert()
                    //self.delegate.gotTheVideos(self.videoArrayOfSermons)
                }
            })
        })
        
        
        task.resume()
        
        return
    }
    
    
    func getVideoSearchesDataFromVimeo(_ theseVideos: String)
    {
        print(theseVideos)
        let URLString = baseURLString + theseVideos
        let myURL = URL(string: URLString)
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("Made a call to Vimeo API for \(theseVideos) ")

            DispatchQueue.main.async(execute: { () -> Void in
                print("Vimeo error: \(error)")
                if let httpResponse = response as? HTTPURLResponse
                {
                    if httpResponse.statusCode != 200
                    {
                        print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }

                
                if let vimeoData = data, let jsonResponse = try? JSONSerialization.jsonObject(with: vimeoData, options: []) as? [String: AnyObject], let myJSON = jsonResponse
                {
                    // here "vimeoData" is the dictionary encoded in JSON data
                      let totalRslts = myJSON["total"] as? Int
                        if totalRslts == 0
                     {
                        self.searchAlert(theseVideos)
                        print("no results")
                     }
                    
                    
                    let dataArray = myJSON["data"] as? [[String: AnyObject]]
                    
                    if let constArray = dataArray
                    {
                        for value in constArray
                        {
                            let video = Video(dictionary: value)
                            self.videoArrayOfSearches.append(video)
                        }
                        //self.delegate.gotTheVideos(self.videoArrayOfSearches)
                         self.delegate.gotTheVideos(withOrder: "c", theVideos: self.videoArrayOfSermons)
                    }
                }
                else
                {
                    self.networkAlert()
                    //self.delegate.gotTheVideos(self.videoArrayOfSearches)
                }
            })
        })
        
        
        task.resume()
        
        return
    }
    
    func syncTheVideos(_ videosOnDisk: [Video])
    {
       videoArrayOfServices = videosOnDisk
        
    }
    
    func syncTheHighlights(_ videosOnDisk: [Video]) {
        videoArrayOfHighlights = videosOnDisk
    }
    
    func syncTheSermons(_ audiosOnDisk: [Video])
    {
        videoArrayOfSermons = audiosOnDisk
//        for xyz in videoArrayOfSermons
//        {
//            if !checkArrayAudioRlm.contains(xyz.uri!)
//            {
//                checkArrayAudioRlm.append(xyz.uri!)
//            }
//        }
    }
    
    
    
    func purgeVideosFromArray()
    {
        videoArrayOfServices.removeAll()
    }
    
    func purgeSermons()
    {
        print("removing ALL from Sermon Audio")
        videoArrayOfSermons.removeAll()
    }
    
    func purgeHighlights() {
        videoArrayOfHighlights.removeAll()
    }
    
    func purgeSearches()
    {
        videoArrayOfSearches.removeAll()
    }
    
    func networkAlert()
    {
        // Create the alert controller
        let alertController1 = UIAlertController(title: "Sorry, having trouble connecting to the network. Please try again later.", message: "Network Unavailable", preferredStyle: .alert)
        // Add the actions
        alertController1.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController1.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        // Present the controller
        alertController1.show()
    }
    
    func searchAlert(_ searchTerm: String)
    {
        let tempSearchArray = searchTerm.components(separatedBy: "=")
        let tempWord = tempSearchArray[1]
        let realTerm = tempWord.removingPercentEncoding
        // Create the alert controller
        let alertController1 = UIAlertController(title: "Sorry, no results found for \(realTerm!).", message: "Try another search.", preferredStyle: .alert)
        // Add the actions
        alertController1.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController1.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        // Present the controller
        alertController1.show()

        
    }

//
    
    
    
}

extension UIAlertController {
    
    func show() {
        present(true, completion: nil)
    }
    
    func present(_ animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(rootVC, animated: animated, completion: completion)
        }
    }
    
    fileprivate func presentFromController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(visibleVC, animated: animated, completion: completion)
        } else
            if let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion);
        }
    }
    
}

extension String {
    static fileprivate let mappings = ["&#8304;" : "⁰", "&#8313;" : "⁹", "&#8312;" : "⁸", "&#8311;" : "⁷", "&#8310;" : "⁶", "&#8309;" : "⁵","&#8308;" : "⁴","&sup3;" : "³", "&sup2;" : "\u{00B2}", "&sup1;" : "¹","&#8729;" : "□", "&#39;" : "'", "&egrave;" : "è","&quot;" : "\"", "&ldquo;" :  "“", "&rdquo;" :  "”", "&rsquo;" :  "’", "&lsquo;" :  "‘", "&mdash;" :  "-", "&ndash;" :  "-", "&hellip;" :  "...",  "&amp;" : "&", "&lt;" : "<", "&gt;" : ">","&nbsp;" : " ","&iexcl;" : "¡","&cent;" : "¢","&pound;" : " £","&curren;" : "¤","&yen;" : "¥","&brvbar;" : "¦","&sect;" : "§","&uml;" : "¨","&copy;" : "©","&ordf;" : " ª","&laquo" : "«","&not" : "¬","&reg" : "®","&macr" : "¯","&deg" : "°","&plusmn" : "±","&sup2; " : "²", "&acute" : "´","&micro" : "µ","&para" : "¶","&middot" : "·","&cedil" : "¸","&sup1" : "¹","&ordm" : "º","&raquo" : "»&","frac14" : "¼","&frac12" : "½","&frac34" : "¾","&iquest" : "¿","&times" : "×","&divide" : "÷","&ETH" : "Ð","&eth" : "ð","&THORN" : "Þ","&thorn" : "þ","&AElig" : "Æ","&aelig" : "æ","&OElig" : "Œ","&oelig" : "œ","&Aring" : "Å","&Oslash" : "Ø","&Ccedil" : "Ç","&ccedil" : "ç","&szlig" : "ß","&Ntilde;" : "Ñ","&ntilde;":"ñ", "&bull;" : "•", "&apos;" : "'"]
    
    func stringByDecodingXMLEntities() -> String {
        
        guard let _ = self.range(of: "&", options: [.literal]) else {
            return self
        }
        
        var result = ""
        
        let scanner = Scanner(string: self)
        scanner.charactersToBeSkipped = nil
        
        let boundaryCharacterSet = CharacterSet(charactersIn: " \t\n\r;")
        // let boundaryCharacterSet = NSCharacterSet(charactersInString: " \t\r;") &apos;
        
        repeat {
            var nonEntityString: NSString? = nil
            
            if scanner.scanUpTo("&", into: &nonEntityString) {
                if let s = nonEntityString as? String {
                    result.append(s)
                }
            }
            
            if scanner.isAtEnd {
                break
            }
            
            var didBreak = false
            for (k,v) in String.mappings {
                if scanner.scanString(k, into: nil) {
                    result.append(v)
                    didBreak = true
                    break
                }
            }
            
            if !didBreak {
                
                if scanner.scanString("&#", into: nil) {
                    
                    var gotNumber = false
                    var charCodeUInt: UInt32 = 0
                    var charCodeInt: Int32 = -1
                    var xForHex: NSString? = nil
                    
                    if scanner.scanString("x", into: &xForHex) {
                        gotNumber = scanner.scanHexInt32(&charCodeUInt)
                    }
                    else {
                        gotNumber = scanner.scanInt32(&charCodeInt)
                    }
                    
                    if gotNumber {
                        let newChar = String(format: "%C", (charCodeInt > -1) ? charCodeInt : charCodeUInt)
                        result.append(newChar)
                        scanner.scanString(";", into: nil)
                    }
                    else {
                        var unknownEntity: NSString? = nil
                        scanner.scanUpToCharacters(from: boundaryCharacterSet, into: &unknownEntity)
                        let h = xForHex ?? ""
                        let u = unknownEntity ?? ""
                        result.append("&#\(h)\(u)")
                    }
                }
                else {
                    scanner.scanString("&", into: nil)
                    result.append("&")
                }
            }
            
        } while (!scanner.isAtEnd)
        
        return result
    }
}



