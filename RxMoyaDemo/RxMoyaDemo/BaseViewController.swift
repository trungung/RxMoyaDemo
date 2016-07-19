//
//  BaseViewController.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
  
  // MARK: Initializing
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  
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
}
