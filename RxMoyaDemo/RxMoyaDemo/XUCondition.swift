//
//  XUCondition.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class XUCondition: Object {
  
  dynamic var text = ""
  dynamic var icon = ""
  dynamic var code = 0
  
  override class func primaryKey() -> String? {
    return "icon"
  }
  
  required convenience init?(_ map: Map) {
    self.init()
    mapping(map)
  }
}

// MARK: - Mappable JSON object
extension XUCondition: Mappable {
  
  func mapping(map: Map) {
    text          <- map["text"]
    icon          <- map["icon"]
    code          <- map["code"]
    
    icon = "https:" + icon
  }
  
  //  class func newInstance() -> Mappable {
  //    return XUCondition()
  //  }
}
