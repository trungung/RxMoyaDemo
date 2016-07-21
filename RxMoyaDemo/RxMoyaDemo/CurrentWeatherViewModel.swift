//
//  CurrentWeatherViewModel.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import Moya_ObjectMapper
import Haneke

let kUnitCelsius = "°C"
let kUnitFahrenheit = "°F"

class CurrentWeatherViewModel {
  
  // Input
  var currentWeather = Variable(XUWeather())
  var city = Variable("")
  var currentTemperature = Variable("")
  var currentUnit = Variable("")
  var currentCondition = Variable("")
  var weatherIconVariable = Variable(XUCondition())
  var changeUnitTaps = PublishSubject<Void>()
  
  // Output
  let executing: Driver<Bool>
  
  // Private
  private let disposeBag = DisposeBag()
  private var tempTypeC = false
  
  let weatherProvider = RxMoyaProvider<Weather>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
  
  init() {
    
    let activityIndicator = ActivityIndicator()
    self.executing = activityIndicator.asDriver().distinctUntilChanged()
    
    changeUnitTaps.asObservable().subscribeNext { () -> Void in
      print("changeUnitTaps")
      self.changeWeatherUnit()
      }.addDisposableTo(disposeBag)    
  }
  
  func changeWeatherUnit() {
    
    tempTypeC = !tempTypeC
    
    // Request Current Weather on local city
    weatherProvider.request(.CurrentWeather("Da Nang"))
      .mapObject(XUCurrentWeather)
      .debug("CurrentWeatherViewModel")
      .subscribe { (event) -> Void in
        switch event {
        case .Next(let response):
          print(response.debugDescription)
          
          self.city.value = (response.location?.name ?? "") + ", " + (response.location?.country ?? "")
          self.currentCondition.value = response.current.condition.text
          self.weatherIconVariable.value = response.current.condition
          if self.tempTypeC {
            let temp = String(format: "%.1f", response.current.temp_c)
            self.currentTemperature.value = temp
            self.currentUnit.value = kUnitCelsius
          } else {
            let temp = String(format: "%.1f", response.current.temp_f)
            self.currentTemperature.value = temp
            self.currentUnit.value = kUnitFahrenheit
          }
        case .Error(let error):
          print(error)
        default:
          break
        }
      }
      .addDisposableTo(disposeBag)
  }
}
