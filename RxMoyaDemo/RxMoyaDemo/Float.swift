//
//  Float.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import Foundation

extension Float {
  
  func string(fractionDigits:Int) -> String {
    
    let formatter = NSNumberFormatter()
    formatter.minimumFractionDigits = fractionDigits
    formatter.maximumFractionDigits = fractionDigits
    return formatter.stringFromNumber(self) ?? "\(self)"
  }
}

