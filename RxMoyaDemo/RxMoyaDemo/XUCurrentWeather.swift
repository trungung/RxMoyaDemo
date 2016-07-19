//
//  XUCurrentWeather.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class XUCurrentWeather: Object {
  
  dynamic var location: XULocation?
  dynamic var current: XUWeather!
  
  required convenience init?(_ map: Map) {
    self.init()
    mapping(map)
  }
}

// MARK: - Mappable JSON object
extension XUCurrentWeather: Mappable {
  
  func mapping(map: Map) {
    location    <- map["location"]
    current     <- map["current"]
  }
}
