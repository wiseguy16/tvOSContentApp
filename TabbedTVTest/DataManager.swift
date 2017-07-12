//
//  DataManager.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 6/5/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    // SINGLETON for controlled data management
    static var sharedData = DataManager()
    
    var ySeries: SeriesItem!
    var ySettings: SeriesItem!
    
    var yThisStudyURL: String!
    var titlesArray: [String]!
    
    var sessionNumbrText = ""

    
    var newWord = ""
    
    
}
