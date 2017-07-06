//
//  FourthCollectionViewCell.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 6/15/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit

class FourthCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var fourthTitleLabel: UILabel!
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    {
        if (self.isFocused)
        {
            self.fourthImageView.adjustsImageWhenAncestorFocused = true
            
        }
            
        else
        {
            self.fourthImageView.adjustsImageWhenAncestorFocused = false
        }
        
    }

    
}
