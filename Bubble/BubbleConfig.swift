//
//  BubbleConfig.swift
//  Bubble
//
//  Created by Dang Quoc Huy on 3/23/17.
//  Copyright © 2017 Dang Quoc Huy. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let X_PROP = SCREEN_WIDTH / 320
let Y_PROP = SCREEN_HEIGHT / 480
let SIZE_PROP = SCREEN_WIDTH / 320
let SMALL_FONT_SIZE = 12.0 * SIZE_PROP
let LARGE_FONT_SIZE = 14.0 * SIZE_PROP
let LARGE_BUBBLE_SIZE: CGFloat = 70
let SMALL_BUBBLE_SIZE: CGFloat = 50

class BubbleConfig: NSObject {

  // Returns an Array of "BubbleInfo" objects
  class func getBubbleInfoArray() -> [BubbleInfo] {
    var createProDataArray = [BubbleInfo]()
    
    do {
      let info = BubbleInfo()
      info.title = "Title 1"
      info.desc = "This is the Description of Title 1 From BubbleInfo file."
      info.bgColor = UIColor.red
      info.frame = CGRect(x: CGFloat(110 * X_PROP), y: CGFloat(110 * Y_PROP), width: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP), height: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP))
      info.titleFontSize = LARGE_FONT_SIZE
      createProDataArray.append(info)
    }
    
    do {
      let info = BubbleInfo()
      info.title = "Title 2"
      info.desc = "This is the Description of Title 2. From BubbleInfo file."
      info.bgColor = UIColor.green
      info.frame = CGRect(x: CGFloat(200 * X_PROP), y: CGFloat(155 * Y_PROP), width: CGFloat(SMALL_BUBBLE_SIZE * SIZE_PROP), height: CGFloat(SMALL_BUBBLE_SIZE * SIZE_PROP))
      info.titleFontSize = SMALL_FONT_SIZE
      createProDataArray.append(info)
    }
    
    do {
      let info = BubbleInfo()
      info.title = "Title 3"
      info.desc = "This is the Description of Title 3. From BubbleInfo file."
      info.bgColor = UIColor.blue
      info.frame = CGRect(x: CGFloat(35 * X_PROP), y: CGFloat(190 * Y_PROP), width: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP), height: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP))
      info.titleFontSize = LARGE_FONT_SIZE
      createProDataArray.append(info)
    }
    
    do {
      let info = BubbleInfo()
      info.title = "Title 4"
      info.desc = "This is the Description of Title 4. From BubbleInfo file."
      info.bgColor = UIColor.brown
      info.frame = CGRect(x: CGFloat(119 * X_PROP), y: CGFloat(187 * Y_PROP), width: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP), height: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP))
      info.titleFontSize = LARGE_FONT_SIZE
      createProDataArray.append(info)
    }
    
    do {
      let info = BubbleInfo()
      info.title = "Title 5"
      info.desc = "This is the Description of Title 5. From BubbleInfo file."
      info.bgColor = UIColor.gray
      info.frame = CGRect(x: CGFloat(175 * X_PROP), y: CGFloat(245 * Y_PROP), width: CGFloat(SMALL_BUBBLE_SIZE * SIZE_PROP), height: CGFloat(SMALL_BUBBLE_SIZE * SIZE_PROP))
      info.titleFontSize = SMALL_FONT_SIZE
      createProDataArray.append(info)
    }
    do {
      let info = BubbleInfo()
      info.title = "Title 6"
      info.desc = "This is the Description of Title 6. From BubbleInfo file."
      info.bgColor = UIColor.magenta
      info.frame = CGRect(x: CGFloat(227 * X_PROP), y: CGFloat(209 * Y_PROP), width: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP), height: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP))
      info.titleFontSize = LARGE_FONT_SIZE
      createProDataArray.append(info)
    }
    
    do {
      let info = BubbleInfo()
      info.title = "Title 7"
      info.desc = "This is the Description of Title 7. From BubbleInfo file."
      info.bgColor = UIColor.orange
      info.frame = CGRect(x: CGFloat(55 * X_PROP), y: CGFloat(266 * Y_PROP), width: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP), height: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP))
      info.titleFontSize = LARGE_FONT_SIZE
      createProDataArray.append(info)
    }
    do {
      let info = BubbleInfo()
      info.title = "Title 8"
      info.desc = "This is the Description of Title 8. From BubbleInfo file."
      info.bgColor = UIColor.purple
      info.frame = CGRect(x: CGFloat(132 * X_PROP), y: CGFloat(295 * Y_PROP), width: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP), height: CGFloat(LARGE_BUBBLE_SIZE * SIZE_PROP))
      info.titleFontSize = LARGE_FONT_SIZE
      createProDataArray.append(info)
    }
    
    return createProDataArray
  }
  
  // Adds Tap gesture to view
  class func addTapGesture(to view: UIView, target: Any, selector: Selector) {
    view.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: target, action: selector)
    tap.numberOfTapsRequired = 1
    view.addGestureRecognizer(tap)
  }
}
