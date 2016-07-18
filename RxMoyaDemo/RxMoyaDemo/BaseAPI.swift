//
//  BaseAPI.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(data: NSData) -> NSData {
  do {
    let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
    let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
    return prettyData
  } catch {
    return data //fallback to original data if it cant be serialized
  }
}

// MARK: - Provider support

public extension String {
  var URLEscapedString: String {
    return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
  }
}


let GitHubProvider = MoyaProvider<GitHub>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

let WeatherProvider = MoyaProvider<Weather>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
