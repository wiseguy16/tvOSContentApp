//
//  ThirdViewController.swift
//  TabbedTVTest
//
//  Created by Greg Wise on 5/10/17.
//  Copyright © 2017 Northland Church. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    @IBOutlet weak var studyCollection: UICollectionView!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
    
    @IBOutlet weak var textView1: UITextView!
    
    
    
    var arrayOfText = ["aaa", "bbb", "ccc", "ddd", "eee", "fff", "ggg", "hhh", "iii", "jjj", "kkk", "lll", "mmm", "nnn"]

    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.text = "ouehrguehghgouih o09iusiqehrguehgouih o09iusiqehrguouih guehgouih o09iusiqehrguehgouih o09iusiqehrguehgouih o09iusiqehrguehgouih o09iusiqehrguehgouih o09iusiqehrguehgouih o09iusiqehrguehgouih o09iusiqiusiq9iu"
        secondLabel.text = "gouih o09iusiqehrguehgouih o09iusiqehrguhrhgouih h o09iusiqehrguehgouih o09iusiqehrguehgouih o09iusiqehrguehgouih o09iusiqiusiq9iu"
        thirdLabel.text = "rguehghgouih o09iusiqehrguehgouih o09iusiqehrguouih o09ehrguehgouih o09iusiqehrghgouih o0hgouih  o09iusiqehrguehgouih o09iusiqehrguehgouih o09iusiqiusiq9iu"
        
        textView1.isUserInteractionEnabled = true
        textView1.isSelectable = true
        textView1.isScrollEnabled = true
        textView1.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouchType.indirect.rawValue)]
        
        
        textView1.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
//        let startPosition: UITextPosition = textView1.beginningOfDocument
//        //let selectedRange: UITextRange? = textView1.selectedTextRange
//        textView1.selectedTextRange = textView1.textRange(from: startPosition, to: startPosition)



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textView1.setContentOffset(.zero, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //return mediaItems.count
        
        return arrayOfText.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudyCell", for: indexPath) as! StudyCollectionViewCell
        
        let thisText = arrayOfText[indexPath.row]
        cell.studyButton.setTitle(thisText, for: .normal)
        cell.studyButton.setTitleColor(.white, for: .normal)
        cell.studyButton.backgroundColor = .lightGray
        //cell.studyButton.setTitleColor(.red, for: .focused)
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        
//        if let cell = context.nextFocusedView as? StudyCollectionViewCell {
//            //let indexPath: IndexPath? = self.collection2.indexPath(for: cell)
//            // let aVid = nextArrayOfVideos[(indexPath!.row)]
        
//        }

        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    {
        var tempColor = UIColor.white
        //print(context.nextFocusedView)
        //print(context.previouslyFocusedView)
        //        context.nextFocusedView?.layer.backgroundColor = UIColor.lightGray.cgColor
        //        if (context.previouslyFocusedView?.isKind(of: StudyCollectionViewCell.self))! {
        //            context.previouslyFocusedView?.layer.backgroundColor = self.studyCollection.backgroundColor?.cgColor
        //        }
        
        //GameCell is a subclass of UICollectionViewCell
        //       if (context.previouslyFocusedView isKindOfClass(StudyCollectionViewCell class]]) {
        //           context.previouslyFocusedView.layer.backgroundColor = self.collectionView.backgroundColor.CGColor
        //       }
        
        
        if let cell = context.nextFocusedView as? StudyCollectionViewCell {
            //tempColor = cell.studyButton.currentTitleColor
            //transferColor = tempColor
            let indexPath: IndexPath? = self.studyCollection.indexPath(for: cell)
            let thisText = arrayOfText[(indexPath?.row)!]
            print(thisText)
            cell.studyButton.setTitleColor(.black, for: .normal)
            cell.studyButton.backgroundColor = .green
            cell.backgroundColor = .white
            
            
//            context.nextFocusedView?.layer.backgroundColor = UIColor.red.cgColor
//            if (context.previouslyFocusedView?.isKind(of: StudyCollectionViewCell.self))! {
//                
//                context.previouslyFocusedView?.layer.backgroundColor = self.studyCollection.backgroundColor?.cgColor
//                
//            }
        }
        
        if let cell = context.previouslyFocusedView as? StudyCollectionViewCell {
            
            let indexPath: IndexPath? = self.studyCollection.indexPath(for: cell)
            let thisText = arrayOfText[(indexPath?.row)!]
            print(thisText)
            cell.studyButton.setTitleColor(tempColor, for: .normal)
            cell.studyButton.backgroundColor = .lightGray
            cell.backgroundColor = .clear
           // cell.studyButton.backgroundColor = .lightGray
            
            
            
            //                context.nextFocusedView?.layer.backgroundColor = UIColor.red.cgColor
            //                if (context.previouslyFocusedView?.isKind(of: StudyCollectionViewCell.self))! {
            //
            //                    context.previouslyFocusedView?.layer.backgroundColor = self.studyCollection.backgroundColor?.cgColor
            //
            //                }
        }
        
//            context.nextFocusedView?.layer.backgroundColor = UIColor.red.cgColor
//            if (context.previouslyFocusedView?.isKind(of: StudyCollectionViewCell.self))! {
//                
//                context.previouslyFocusedView?.layer.backgroundColor = self.studyCollection.backgroundColor?.cgColor
//                
//            }

            
        
        
        
        
        // let aVid = nextArrayOfVideos[(indexPath!.row)]
        
        
        //            coordinator.addCoordinatedAnimations({
        //                let duration : TimeInterval = UIView.inheritedAnimationDuration
        //                UIView.animate(withDuration: (1.0 * duration), delay: 0.0, options: UIViewAnimationOptions.overrideInheritedDuration, animations: {
        //                    //add your animations
        //                    cell.studyButton.setTitleColor(.red, for: .focused)
        //                    
        //                }, completion: nil)
        //            }, completion: nil)
        
        
    }







    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
