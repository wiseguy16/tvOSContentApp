//
//  StudyCollectionViewCell.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 5/10/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit

class StudyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var studyLabel: UILabel!
    
    @IBOutlet weak var studyButton: UIButton!
    
    @IBOutlet weak var studyImageView: UIImageView!
    
//    override var preferredFocusEnvironments: [UIFocusEnvironment] {
//        // Condition
//    }
//    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
//        // Condition
//        return true
//    }
//    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        // Condition
//    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    {
        
        if (self.isFocused)
        {
            self.studyImageView.adjustsImageWhenAncestorFocused = true
            
        }
            
        else
        {
            self.studyImageView.adjustsImageWhenAncestorFocused = false
        }
        
    }

    
}
