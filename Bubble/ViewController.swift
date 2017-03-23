//
//  ViewController.swift
//  Bubble
//
//  Created by Dang Quoc Huy on 3/23/17.
//  Copyright © 2017 Dang Quoc Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var bubbleAnimationView: BubbleAnimationView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: Private Methods
  
  func addBuubleAnimationView() {
    bubbleAnimationView?.removeFromSuperview()
    bubbleAnimationView = nil
    bubbleAnimationView = BubbleAnimationView(frame: self.view.frame)
    view.addSubview(self.bubbleAnimationView!)
    bubbleAnimationView?.animateBuubleViews()
  }
  
  // MARK: IBAction
  
  @IBAction func startButtonPressed(_ sender: UIBarButtonItem) {
    addBuubleAnimationView()
  }

}
