//
//  FirstCollectionViewCell.swift
//  TestTV
//
//  Created by Greg Wise on 5/8/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit
import SDWebImage

class FirstCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    {
        if (self.isFocused)
        {
            self.firstImageView.adjustsImageWhenAncestorFocused = true
            
        }
            
        else
        {
            self.firstImageView.adjustsImageWhenAncestorFocused = false
        }
        
//        coordinator.addCoordinatedAnimations({
//            if self.isFocused {
//                self.firstImageView.alpha = 1.0 // in focus
//            }
//            else {
//                self.firstImageView.alpha = 0.5 // leaving focus
//            }
//        }, completion: nil)
    }

    
}
