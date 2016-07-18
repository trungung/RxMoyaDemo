//
//  WeatherAPI.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import Foundation
import Moya

public enum Weather {
  case CurrentWeather(String)
  case CurrentWeatherWithDays(String, Int)
  case Forecast(String, Int)
  case History(String, String)  // Date on or after 1st Jan, 2015 in yyyy-MM-dd formatShow Response
  case SearchCities(String)
}

private enum WeatherAPIMethod: String {
  case CurrentWeather = "/current.json"
  case Forecast = "/forecast.json"
  case Search = "/search"
  case History = "/history"
}

extension Weather: TargetType {
  
  public var baseURL: NSURL { return NSURL(string: "https://api.apixu.com/v1")! }
  
  public var path: String {
    switch self {
    case .CurrentWeather( _):
      return WeatherAPIMethod.CurrentWeather.rawValue
    case .CurrentWeatherWithDays( _, _):
      return WeatherAPIMethod.CurrentWeather.rawValue
    case .Forecast( _, _):
      return WeatherAPIMethod.Forecast.rawValue
    case .SearchCities( _):
      return WeatherAPIMethod.Search.rawValue
    case .History( _, _):
      return WeatherAPIMethod.History.rawValue
    }
  }
  
  public var method: Moya.Method {
    return .GET
  }
  
  public var parameters: [String: AnyObject]? {
    switch self {
    case .CurrentWeather(let city):
      return ["key": kXUAPIKey, "q": city]
    case .CurrentWeatherWithDays(let city, let days):
      return ["key": kXUAPIKey, "q": city, "days": days]
    case .Forecast(let city, let days):
      return ["key": kXUAPIKey, "q": city, "days": days]
    case .SearchCities(let city):
      return ["key": kXUAPIKey, "q": city]
    case .History(let city, let date):
      return ["key": kXUAPIKey, "q": city, "dt": date]
    }
  }
  
  //  public var multipartBody: [MultipartFormData]? {
  //    return nil
  //  }
  
  public var sampleData: NSData {
    switch self {
    case .CurrentWeather(let name):
      return "{\(name)}".dataUsingEncoding(NSUTF8StringEncoding)!
    default:
      return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
  }
}
