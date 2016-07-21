//
//  XUWeather.swift
//  RxMoyaDemo
//
//  Created by trung ung on 7/18/16.
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class XUWeather: Object {
  
  dynamic var last_updated_epoch = 0
  dynamic var last_updated = ""
  dynamic var is_day = false
  
  dynamic var condition: XUCondition!
  
  dynamic var temp_c = 0.0
  dynamic var temp_f = 0.0
  
  dynamic var wind_mph = 0.0
  dynamic var wind_kph = 0.0
  dynamic var wind_degree = 0.0
  dynamic var wind_dir = ""
  dynamic var pressure_mb = 0
  dynamic var pressure_in = 0.0
  dynamic var precip_mm = 0
  dynamic var precip_in = 0
  dynamic var humidity = 0
  dynamic var cloud = 0
  dynamic var feelslike_c = 0.0
  dynamic var feelslike_f = 0.0
  
  required convenience init?(_ map: Map) {
    self.init()
    mapping(map)
  }
}

// MARK: - Mappable JSON object
extension XUWeather: Mappable {
  
  func mapping(map: Map) {
    last_updated_epoch      <- map["last_updated_epoch"]
    last_updated            <- map["last_updated"]
    is_day                  <- map["is_day"]
    condition               <- map["condition"]
    temp_c                  <- map["temp_c"]
    temp_f                  <- map["temp_f"]
    wind_mph                <- map["wind_mph"]
    wind_kph                <- map["wind_kph"]
    wind_degree             <- map["wind_degree"]
    wind_dir                <- map["wind_dir"]
    pressure_mb             <- map["pressure_mb"]
    pressure_in             <- map["pressure_in"]
    precip_mm               <- map["precip_mm"]
    precip_in               <- map["precip_in"]
    humidity                <- map["humidity"]
    cloud                   <- map["cloud"]
    feelslike_c             <- map["feelslike_c"]
    feelslike_f             <- map["feelslike_f"]
  }
  
  //  class func newInstance() -> Mappable {
  //    return XUWeather()
  //  }
}
