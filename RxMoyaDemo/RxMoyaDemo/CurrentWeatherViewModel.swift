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
  var city = Variable("")
  
  var currentTemperature = Variable("")
  var currentUnit = Variable("")
  
  var weatherIconVariable = Variable("")
  
  // Output
  
  //  let weatherFinished: Observable<XUWeather>
  //  let requestExecuting: Observable<Bool>
  
  var cityName = PublishSubject<String>()
  var degrees = PublishSubject<String>()
  var unit = PublishSubject<String>()
  
  // Private
  private let disposeBag = DisposeBag()
  
  let weatherProvider = RxMoyaProvider<Weather>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
  
  init() {
    
    weatherProvider.request(.CurrentWeather("Da Nang"))
      .mapObject(XUCurrentWeather)
      .subscribe { (event) -> Void in
        switch event {
        case .Next(let response):
          print(response.debugDescription)
          
          self.cityName.onNext((response.location?.name ?? "") + ", " + (response.location?.country ?? ""))
          self.degrees.onNext("\(response.current.temp_c)")
          self.unit.onNext(kUnitCelsius)
          self.weatherIconVariable.value = response.current.condition?.icon ?? ""
          
        case .Error(let error):
          print(error)
        default:
          break
        }
      }
      .addDisposableTo(disposeBag)
  }
}
