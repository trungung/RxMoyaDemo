//
//  CurrentWeatherViewController.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrentWeatherViewController: BaseViewController {
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var currentUnitLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var dayLabel: UILabel!
  
  var viewModel: CurrentWeatherViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = CurrentWeatherViewModel()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(CurrentWeatherViewController.changeUnitFunction(_:)))
    currentTempLabel.addGestureRecognizer(tap)
    
    bindToRx()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel.changeWeatherUnit()
  }
  
  func changeUnitFunction(sender:UITapGestureRecognizer) {
    viewModel.changeUnitTaps.on(.Next())
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func bindToRx() {
    
    viewModel.city.asObservable().subscribe(cityLabel.rx_text).addDisposableTo(disposeBag)
    viewModel.currentTemperature.asObservable().subscribe(currentTempLabel.rx_text).addDisposableTo(disposeBag)
    viewModel.currentUnit.asObservable().subscribe(currentUnitLabel.rx_text).addDisposableTo(disposeBag)
    viewModel.currentCondition.asObservable().subscribe(dayLabel.rx_text).addDisposableTo(disposeBag)
    
    viewModel.executing.driveNext { (loading) in
      if loading {
        self.showLoadingIndicator()
      } else {
        self.hideLoadingIndicator()
      }
      }.addDisposableTo(disposeBag)
    
    viewModel.weatherIconVariable
      .asObservable()
      .observeOn(MainScheduler.instance)
      .subscribeNext { (condition) in
        self.iconImageView.hnk_setImageFromURL(NSURL(string: condition.icon)!)
        if condition.code == 1000 {
          UIView.animateWithDuration(2.0, delay: 0, options: .Repeat, animations: { 
            self.iconImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            }, completion: nil)
        } else {
          self.iconImageView.transform = CGAffineTransformMakeRotation(0)
        }
      }
      .addDisposableTo(disposeBag)
  }
}
