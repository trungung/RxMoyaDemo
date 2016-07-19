//
//  XULocation.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class XULocation: Object {
  
  dynamic var name = ""
  dynamic var region = ""
  dynamic var country = ""
  dynamic var lat = 0.0
  dynamic var lon = 0.0
  dynamic var tz_id = ""
  dynamic var localtime_epoch = 0
  dynamic var localtime = ""
  
  /*
   Only properties of type String and Int can be designated as the primary key. Primary key
   properties enforce uniqueness for each value whenever the property is set which incurs some overhead.
   Indexes are created automatically for primary key properties.
   */
  override class func primaryKey() -> String? {
    return "name"
  }
  
  required convenience init?(_ map: Map) {
    self.init()
    mapping(map)
  }
}

// MARK: - Mappable JSON object
extension XULocation: Mappable {
  
  func mapping(map: Map) {
    region           <- map["region"]
    name             <- map["name"]
    country          <- map["country"]
    lat              <- map["lat"]
    lon              <- map["lon"]
    tz_id            <- map["tz_id"]
    localtime_epoch  <- map["localtime_epoch"]
    localtime        <- map["localtime"]
  }
  
  //  class func newInstance() -> Mappable {
  //    return XULocation()
  //  }
}
