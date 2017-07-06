//
//  SecondCollectionViewCell.swift
//  TestTV
//
//  Created by Greg Wise on 5/8/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit
import SDWebImage

class SecondCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var secondTitleLabel: UILabel!
    
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    {
        if (self.isFocused)
        {
            self.secondImageView.adjustsImageWhenAncestorFocused = true
            
        }
            
        else
        {
            self.secondImageView.adjustsImageWhenAncestorFocused = false
        }
        
    }
}
