//
//  BaseViewController.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import UIKit
import RxSwift
import JHSpinner

class BaseViewController: UIViewController {
  
  // Spinner Indicator
  var spinner: JHSpinnerView?
  
  // MARK: Initializing
  
  //  init() {
  //    super.init(nibName: nil, bundle: nil)
  //  }
  //  
  //  required convenience init?(coder aDecoder: NSCoder) {
  //    self.init()
  //  }
  
  // MARK: Rx
  
  let disposeBag = DisposeBag()
  
  
  // MARK: Layout Constraints
  
  private(set) var didSetupConstraints = false
  
  override func viewDidLoad() {
    self.view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  func setupConstraints() {
    // Override point
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showLoadingIndicator() {
    
    if spinner == nil {
      //      spinner = JHSpinnerView.showDeterminiteSpinnerOnView(self.view)
      //      spinner = JHSpinnerView.showOnView(self.view, spinnerColor:UIColor.redColor(), overlay:.Circular, overlayColor:UIColor.blackColor().colorWithAlphaComponent(0.4), fullCycleTime:4.0)
      
      spinner = JHSpinnerView.showDeterminiteSpinnerOnView(appDelegate.window!, spinnerColor:UIColor.whiteColor(), backgroundColor:UIColor.blackColor().colorWithAlphaComponent(0.4), fullCycleTime:8.0, initialProgress:0.0)
      spinner?.addCircleBorder(UIColor.redColor(), progress: 50.0)
      spinner!.progress = 100.0
      appDelegate.window!.addSubview(spinner!)
    }
    
    spinner?.alpha = 1.0
    spinner!.animate()
  }
  
  func hideRightNavigationButtonItem() {
    
    self.tabBarController?.navigationItem.rightBarButtonItem = nil
  }
  
  func hideLoadingIndicator() {
    if (spinner != nil) {
      spinner?.alpha = 0.0
    }
  }
}
