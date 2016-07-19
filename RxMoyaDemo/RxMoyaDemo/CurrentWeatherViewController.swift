//
//  CurrentWeatherViewController.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrentWeatherViewController: UIViewController {
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var currentUnitLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var dayLabel: UILabel!
  
  var viewModel: CurrentWeatherViewModel!
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = CurrentWeatherViewModel()
    bindToRx()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func bindToRx() {
    
    viewModel.cityName.bindTo(cityLabel.rx_text).addDisposableTo(disposeBag)
    viewModel.degrees.bindTo(currentTempLabel.rx_text).addDisposableTo(disposeBag)
    viewModel.unit.bindTo(currentUnitLabel.rx_text).addDisposableTo(disposeBag)
    
    viewModel.weatherIconVariable
      .asObservable()
      .observeOn(MainScheduler.instance)
      .subscribeNext { (imageUrl) in
        self.iconImageView.hnk_setImageFromURL(NSURL(string: imageUrl)!)
      }
      .addDisposableTo(disposeBag)
    
    UIView.animateWithDuration(2.0, delay: 0, options: .Repeat, animations: {
      self.iconImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
    }) { (success) in
      
    }
  }
}
