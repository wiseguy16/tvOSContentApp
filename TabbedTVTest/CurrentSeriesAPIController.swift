//
//  CurrentSeriesAPIController.swift
//  NacdFeatured
//
//  Created by Gregory Weiss on 1/3/17.
//  Copyright © 2017 NorthlandChurch. All rights reserved.
//

import Foundation
import UIKit

class CurrentSeriesAPIController
{
    
    
    init(delegate: CurrentSeriesAPIControllerProtocol)
    {
        self.delegate = delegate
    }
    
    
    //var arrayOfFeatured = [Featured]()
    // var arrayOfBlogs = [Featured]()
    var arrayOfSeries = [SeriesItem]()
    var arrayOfConfiguration = [SeriesItem]()
    
    var arrayOfPreviousSeries = [SeriesItem]()
    var arrayOfPreviousConfigurations = [SeriesItem]()
    
    var arrayOfIndividualConfiguration = [SeriesItem]()
    
    
    var delegate: CurrentSeriesAPIControllerProtocol!
    // let baseURLString = "http://www.northlandchurch.net/index.php/resources/iphone-app-getseries/"
    
    
    // ************************************* THIS IS THE REAL URL  **********************************************************
    
    let baseURLString = "https://www.northlandchurch.net/api/get-session-by-id/"
    
    // ************************************* THIS IS THE REAL URL  **********************************************************
    
    
    // let baseURLString = "http://www.northlandchurch.net/api/get-session-by-id-staging/"  // STAGING ENPOINT !!!  MUST UNDO FOR DISTRIBUTION!!!!!
    
    
    func removeSpecialCharsFromString(_ str: String) -> String {
        let chars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_/@[]{}".characters)
        return String(str.characters.filter { chars.contains($0) })
    }
    
    func removeBackslashes(_ str: String) -> String
    {
        var newStr = str
        newStr = newStr.replacingOccurrences(of: "\t", with: "")
        newStr = newStr.replacingOccurrences(of: "\n", with: "")
        newStr = newStr.replacingOccurrences(of: "\\", with: "")
        
        return newStr
    }
    
    
    func getCurrentSeriesDataFromNACD(_ thisSession: String)
    {
        //  "h ttp://www.northlandchurch.net/index.php/resources/iphone-app-getseries"
        
        let URLString = baseURLString + thisSession
        let myURL = URL(string: URLString)
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        //request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                if let httpResponse = response as? HTTPURLResponse
                {   //print(httpResponse)
                    if httpResponse.statusCode != 200
                    {
                        //  print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }
                
                if let apiData = data
                {   //print(apiData)
                    if let datastring = String(data: apiData, encoding: String.Encoding.utf8)
                    {
                        
                        //print(datastring)
                        let data2 = self.removeBackslashes(datastring)
                        // print(data2)
                        let data1 = data2.data(using: String.Encoding.utf8)
                        //print(data1!)
                        
                        if let apiData = data1, let jsonOutput = try? JSONSerialization.jsonObject(with: apiData, options: []) as? [String: AnyObject], let myJSON = jsonOutput
                        {
                            let dataArray = myJSON["items"] as? [[String: AnyObject]]
                            
                            if let constArray = dataArray
                            {
                                for value in constArray
                                {
                                    let aSrs = SeriesItem(myDictionary: value)
                                    self.arrayOfSeries.append(aSrs)
                                }
                                self.delegate.gotTheSeries(self.arrayOfSeries)
                            }
                        }
                    }
                }
                else
                {
                    self.networkAlert()
                    //  self.delegate.gotTheBible(self.arrayOfLiturgy)
                }
                
            })
        })
        
        
        task.resume()
        
        return
    }
    
    
    func getPreviousSeriesDataFromNACD(_ thisSession: String)
    {
        //  "h ttp://www.northlandchurch.net/index.php/resources/iphone-app-getseries"
        
        let URLString = baseURLString + thisSession
        let myURL = URL(string: URLString)
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        //request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                if let httpResponse = response as? HTTPURLResponse
                {   print(httpResponse)
                    if httpResponse.statusCode != 200
                    {
                        print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }
                
                if let apiData = data
                {  // print(apiData)
                    if let datastring = String(data: apiData, encoding: String.Encoding.utf8)
                    {
                        
                        //print(datastring)
                        let data2 = self.removeBackslashes(datastring)
                        // print(data2)
                        let data1 = data2.data(using: String.Encoding.utf8)
                        //print(data1!)
                        
                        if let apiData = data1, let jsonOutput = try? JSONSerialization.jsonObject(with: apiData, options: []) as? [String: AnyObject], let myJSON = jsonOutput
                        {
                            let dataArray = myJSON["items"] as? [[String: AnyObject]]
                            
                            if let constArray = dataArray
                            {
                                for value in constArray
                                {
                                    let aSrs = SeriesItem(myDictionary: value)
                                    self.arrayOfPreviousSeries.append(aSrs)
                                }
                                self.delegate.gotTheSeries(self.arrayOfPreviousSeries)
                            }
                        }
                    }
                }
                else
                {
                    self.networkAlert()
                    //  self.delegate.gotTheBible(self.arrayOfLiturgy)
                }
                
            })
        })
        
        
        task.resume()
        
        return
    }
    
    
    
    
    func getSeriesConfigurationDataFromNACD()
    {
        //  "h ttp://www.northlandchurch.net/index.php/resources/iphone-app-getseries"  https://api.myjson.com/bins/d37df
        // let URLString = "http://www.northlandchurch.net/index.php/resources/iphone-app-getsession"
        // let URLString = "https://northlandchurch.net/api/get-all-study-guides/"
        
        
        // ************************************* THIS IS THE REAL URL  **********************************************************
        
        
        let URLString = "https://northlandchurch.net/api/get-study-guide-by-id"
        
        // ************************************* THIS IS THE REAL URL  **********************************************************
        
        //     let URLString = "https://northlandchurch.net/api/get-study-guide-by-id-staging"  // STAGING ENPOINT !!!  MUST UNDO FOR DISTRIBUTION!!!!!
        
        //  let URLString = "https://api.myjson.com/bins/n8p0f"
        
        let myURL = URL(string: URLString)
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        //request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                if let httpResponse = response as? HTTPURLResponse
                {  // print(httpResponse)
                    if httpResponse.statusCode != 200
                    {
                        print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }
                
                if let apiData = data
                {   //print(apiData)
                    if let datastring = String(data: apiData, encoding: String.Encoding.utf8)
                    {
                        
                        //print(datastring)
                        let data2 = self.removeBackslashes(datastring)
                        // print(data2)
                        let data1 = data2.data(using: String.Encoding.utf8)
                        //print(data1!)
                        
                        if let apiData = data1, let jsonOutput = try? JSONSerialization.jsonObject(with: apiData, options: []) as? [String: AnyObject], let myJSON = jsonOutput
                        {
                            let dataArray = myJSON["items"] as? [[String: AnyObject]]
                            
                            if let constArray = dataArray
                            {
                                for value in constArray
                                {
                                    let aSrs = SeriesItem(myDictionary: value)
                                    self.arrayOfConfiguration.append(aSrs)
                                }
                                self.delegate.gotTheConfigSettings(self.arrayOfConfiguration)
                            }
                        }
                    }
                }
                else
                {
                    self.networkAlert()
                    //  self.delegate.gotTheBible(self.arrayOfLiturgy)
                }
                
            })
        })
        
        
        task.resume()
        
        return
    }
    
    
    func getPreviousSeriesConfigurationDataFromNACD()
    {
        //  "h ttp://www.northlandchurch.net/index.php/resources/iphone-app-getseries"
        
        //let URLString = "h ttp://www.northlandchurch.net/index.php/resources/iphone-app-getsession"
        
        
        
        // ****************************  THIS IS THE REAL ENDPOINT !!  ********************************
        
        let URLString = "https://www.northlandchurch.net/api/get-all-study-guides/"
        
        // ****************************  THIS IS THE REAL ENDPOINT !!  ********************************
        
        
        
        //  let URLString = "http://www.northlandchurch.net/api/get-all-study-guides-staging/" // STAGING ENPOINT !!!  MUST UNDO FOR DISTRIBUTION!!!!!
        
        
        let myURL = URL(string: URLString)
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        //request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                if let httpResponse = response as? HTTPURLResponse
                {  // print(httpResponse)
                    if httpResponse.statusCode != 200
                    {
                        // print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }
                
                if let apiData = data
                {   //print(apiData)
                    if let datastring = String(data: apiData, encoding: String.Encoding.utf8)
                    {
                        
                        //print(datastring)
                        let data2 = self.removeBackslashes(datastring)
                        // print(data2)
                        let data1 = data2.data(using: String.Encoding.utf8)
                        //print(data1!)
                        
                        if let apiData = data1, let jsonOutput = try? JSONSerialization.jsonObject(with: apiData, options: []) as? [String: AnyObject], let myJSON = jsonOutput
                        {
                            let dataArray = myJSON["items"] as? [[String: AnyObject]]
                            
                            if let constArray = dataArray
                            {
                                for value in constArray
                                {
                                    let aSrs = SeriesItem(myDictionary: value)
                                    self.arrayOfPreviousConfigurations.append(aSrs)
                                }
                                self.delegate.gotTheConfigSettings(self.arrayOfPreviousConfigurations)
                            }
                        }
                    }
                }
                else
                {
                    self.networkAlert()
                    //  self.delegate.gotTheBible(self.arrayOfLiturgy)
                }
                
            })
        })
        
        
        task.resume()
        
        return
    }
    
    func getIndividualPreviousSeriesConfigurationDataFromNACD(_ thisSession: String)
    {
        //  "h ttp://www.northlandchurch.net/index.php/resources/iphone-app-getseries"
        
        //let URLString = "http://www.northlandchurch.net/index.php/resources/iphone-app-getsession"
        //let URLString = "http://www.northlandchurch.net/api/get-study-guide-by-id/"
        let URLString = thisSession
        
        
        // let myURL = URL(string: URLString + thisSession)
        let myURL = URL(string: URLString)
        
        var request = URLRequest(url: myURL!)
        
        request.httpMethod = "GET"  // Compose a query string
        //request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                if let httpResponse = response as? HTTPURLResponse
                {  // print(httpResponse)
                    if httpResponse.statusCode != 200
                    {
                        // print("You got 404!!!???")
                        self.networkAlert()
                        return
                    }
                }
                
                if let apiData = data
                {   //print(apiData)
                    if let datastring = String(data: apiData, encoding: String.Encoding.utf8)
                    {
                        
                        //print(datastring)
                        let data2 = self.removeBackslashes(datastring)
                        //  print(data2)
                        let data1 = data2.data(using: String.Encoding.utf8)
                        //print(data1!)
                        
                        if let apiData = data1, let jsonOutput = try? JSONSerialization.jsonObject(with: apiData, options: []) as? [String: AnyObject], let myJSON = jsonOutput
                        {
                            let dataArray = myJSON["items"] as? [[String: AnyObject]]
                            //self.purgePreviousSettings()
                            
                            if let constArray = dataArray
                            {
                                for value in constArray
                                {
                                    let aSrs = SeriesItem(myDictionary: value)
                                    //self.arrayOfPreviousConfigurations.append(aSrs)
                                    self.arrayOfIndividualConfiguration.append(aSrs)
                                    
                                }
                                //self.delegate.gotTheConfigSettings(self.arrayOfPreviousConfigurations)
                                self.delegate.gotTheConfigSettings(self.arrayOfIndividualConfiguration)
                                
                            }
                        }
                    }
                }
                else
                {
                    self.networkAlert()
                    //  self.delegate.gotTheBible(self.arrayOfLiturgy)
                }
                
            })
        })
        
        
        task.resume()
        
        return
    }
    
    
    
    func purgePreviousSeries()
    {
        arrayOfPreviousSeries.removeAll()
    }
    
    func purgePreviousSettings()
    {
        arrayOfPreviousConfigurations.removeAll()
    }
    
    
    
    
    
    
    func purgeSeries()
    {
        arrayOfSeries.removeAll()
    }
    
    func purgeSettings()
    {
        arrayOfConfiguration.removeAll()
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
    
    //
    
    
}
