//
//  BubbleAnimationView.swift
//  Bubble
//
//  Created by Dang Quoc Huy on 3/23/17.
//  Copyright © 2017 Dang Quoc Huy. All rights reserved.
//

import Foundation
import UIKit

let TITLE_TAG = 100
let SUBTITLE_TAG = 101
let ZOOM_ANIMATION_DURATION: CGFloat = 0.3

class BubbleAnimationView: UIView {
  var previousIndex: Int = 0
  
  var bubbleInfoArray = [BubbleInfo]()
  var bubbleViewsArray = [UIView]()
  var animationTimer: Timer!
  var selectedBubbleView: UIView!
  var overlayBubbleView: UIView!
  var bubbleContainerView: UIView!
  var tapOutsideDismiss: UITapGestureRecognizer!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Private methods
  
  func addGestureForTapOutside() {
    tapOutsideDismiss = UITapGestureRecognizer(target: self, action: #selector(tapOutSideDismissFunc))
    tapOutsideDismiss.numberOfTapsRequired = 1
    bubbleContainerView.addGestureRecognizer(tapOutsideDismiss)
    tapOutsideDismiss.isEnabled = false
  }
  
  func animateBuubleViews() {
    backgroundColor = UIColor.black
    alpha = 0.7
    bubbleContainerView = UIView(frame: frame)
    bubbleContainerView.backgroundColor = UIColor.clear
    addSubview(bubbleContainerView)
    addGestureForTapOutside()
    bubbleInfoArray = BubbleConfig.getBubbleInfoArray()
    bubbleViewsArray = [UIView]()
    
    for info: BubbleInfo in bubbleInfoArray {
      let bubbleView = UIView(frame: info.frame)
      bubbleView.layer.cornerRadius = bubbleView.frame.size.width / 2
      bubbleView.clipsToBounds = true
      bubbleView.backgroundColor = info.bgColor
      bubbleView.tag = bubbleInfoArray.index(of: info)!
      
      // Title Label
      let titleLabel = UILabel(frame: CGRect(x: CGFloat(5), y: CGFloat(bubbleView.frame.size.height / 2 - 20), width: CGFloat(bubbleView.frame.size.width - 10), height: CGFloat(40)))
      titleLabel.textAlignment = .center
      titleLabel.numberOfLines = 3
      titleLabel.text = info.title
      titleLabel.font = UIFont(name: "Helvetica", size: CGFloat(info.titleFontSize))
      titleLabel.textColor = UIColor.white
      titleLabel.tag = TITLE_TAG
      
      bubbleView.addSubview(titleLabel)
      bubbleContainerView.addSubview(bubbleView)
      BubbleConfig.addTapGesture(to: bubbleView, target: self, selector: #selector(self.onTapBubbleViews))
      bubbleViewsArray.append(bubbleView)
    }
    
    for view: UIView in bubbleViewsArray {
      view.isUserInteractionEnabled = false
      view.isHidden = true
    }
    
    perform(#selector(animateBubbleViews), with: nil, afterDelay: 0.2)
  }
  
  func animateBubbleViews(_ sender: Any) {
    animationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateSingleBubble), userInfo: nil, repeats: true)
  }
  
  func animateSingleBubble(_ snder: Any) {
    if previousIndex < bubbleViewsArray.count {
      let view: UIView = bubbleViewsArray[previousIndex]
      previousIndex += 1
      view.isHidden = false
      animate(view)
    }
    else {
      animationTimer.invalidate()
      for view: UIView in bubbleViewsArray {
        view.isUserInteractionEnabled = true
      }
    }
  }
  
  func animate(_ view: UIView) {
    view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.30, initialSpringVelocity: 5.0, options: .allowUserInteraction, animations: {() -> Void in
      view.transform = CGAffineTransform.identity
    }, completion: {(_ finished: Bool) -> Void in
    })
  }
  
  func getScalingfactor() -> CGFloat {
    let viewWidth: CGFloat = selectedBubbleView.frame.size.width
    return 200.0 / viewWidth
  }
  
  func springAnimation(onBubble matrixVal: CGFloat, zoomVal: CGFloat, movement: Bool, iteration: Int) {
    if zoomVal >= ZOOM_ANIMATION_DURATION / 10 {
      UIView.animate(withDuration: TimeInterval(zoomVal), animations: {() -> Void in
        self.selectedBubbleView.transform = CGAffineTransform(scaleX: self.selectedBubbleView.transform.a - matrixVal, y: self.selectedBubbleView.transform.d - matrixVal)
      }, completion: {(_ finished: Bool) -> Void in
        let matrixValue: CGFloat = !movement ? -(matrixVal * 0.5) : -(matrixVal)
        let iter: Int = iteration + 1
        self.springAnimation(onBubble: matrixValue, zoomVal: ZOOM_ANIMATION_DURATION / CGFloat(iter + 1), movement: !movement, iteration: iter)
      })
    }
    else {
      tapOutsideDismiss.isEnabled = true
    }
  }
  
  func onTapBubbleViews(_ recognizer: UITapGestureRecognizer) {
    selectedBubbleView = recognizer.view
    
    for view: UIView in bubbleViewsArray {
      if view.tag != selectedBubbleView.tag {
        view.isHidden = true
      }
    }
    
    bubbleContainerView.bringSubview(toFront: selectedBubbleView)
    UIView.animate(withDuration: TimeInterval(ZOOM_ANIMATION_DURATION), animations: {() -> Void in
      self.selectedBubbleView.transform = CGAffineTransform(scaleX: self.getScalingfactor() + 1, y: self.getScalingfactor() + 1)
      self.selectedBubbleView.center = self.bubbleContainerView.center
      let label: UILabel? = (self.selectedBubbleView.viewWithTag(TITLE_TAG) as? UILabel)
      label?.alpha = 0.0
    }, completion: {(_ finished: Bool) -> Void in
      self.springAnimation(onBubble: 1, zoomVal: ZOOM_ANIMATION_DURATION / 2, movement: false, iteration: 1)
      self.overlayBubbleView = UIView(frame: self.selectedBubbleView.frame)
      self.overlayBubbleView.layer.cornerRadius = self.overlayBubbleView.frame.size.width / 2
      self.overlayBubbleView.clipsToBounds = true
      self.overlayBubbleView.backgroundColor = self.selectedBubbleView.backgroundColor
      let data: BubbleInfo? = self.bubbleInfoArray[self.selectedBubbleView.tag]
      
      // title label
      let titleLabel = UILabel()
      titleLabel.text = data?.title
      titleLabel.numberOfLines = 2
      titleLabel.font = UIFont(name: "Helvetica", size: CGFloat(25.0))
      titleLabel.textAlignment = .center
      titleLabel.textColor = UIColor.white
      titleLabel.tag = TITLE_TAG
      titleLabel.frame = CGRect(x: CGFloat(25), y: CGFloat(40), width: CGFloat(self.overlayBubbleView.frame.size.width - 50), height: CGFloat(40))
      
      // Subtitle Label
      let subTitleLabel = UILabel()
      subTitleLabel.text = data?.desc
      subTitleLabel.numberOfLines = 10
      subTitleLabel.font = UIFont(name: "Helvetica", size: CGFloat(15.0))
      subTitleLabel.textAlignment = .center
      subTitleLabel.textColor = UIColor.white
      subTitleLabel.tag = SUBTITLE_TAG
      subTitleLabel.alpha = 0.6
      subTitleLabel.frame = CGRect(x: CGFloat(15), y: CGFloat(titleLabel.frame.origin.y + titleLabel.frame.size.height + 5), width: CGFloat(self.overlayBubbleView.frame.size.width - 30), height: CGFloat(70))
      subTitleLabel.sizeToFit()
      self.overlayBubbleView.addSubview(subTitleLabel)
      self.bubbleContainerView.addSubview(self.overlayBubbleView)
      self.overlayBubbleView.alpha = 0.0
      UIView.animate(withDuration: 0.3, animations: {() -> Void in
        self.overlayBubbleView.alpha = 1.0
      }, completion: {(_ finished: Bool) -> Void in
      })
    })
  }
  
  func tapOutSideDismissFunc(_ recognizer: UITapGestureRecognizer) {
    self.tapOutsideDismiss.isEnabled = false
    
    for view: UIView in self.bubbleViewsArray {
      view.isHidden = false
    }
    
    self.overlayBubbleView.removeFromSuperview()
    UIView.animate(withDuration: TimeInterval(ZOOM_ANIMATION_DURATION), animations: {() -> Void in
      self.selectedBubbleView.transform = CGAffineTransform.identity
      let label: UILabel? = (self.selectedBubbleView.viewWithTag(TITLE_TAG) as? UILabel)
      label?.alpha = 1.0
      let info: BubbleInfo? = self.bubbleInfoArray[self.selectedBubbleView.tag]
      self.selectedBubbleView.frame = (info?.frame)!
    }, completion: {(_ finished: Bool) -> Void in
    })
  }
  
}
