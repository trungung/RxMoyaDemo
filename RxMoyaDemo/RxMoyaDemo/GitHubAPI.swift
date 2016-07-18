//
//  GitHubAPI.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import Foundation
import Moya

public enum GitHub {
  case UserProfile(String)
  case UserRepositories(String)
}

extension GitHub: TargetType {
  
  public var baseURL: NSURL { return NSURL(string: "https://api.github.com")! }
  public var path: String {
    switch self {
    case .UserProfile(let name):
      return "/users/\(name.URLEscapedString)"
    case .UserRepositories(let name):
      return "/users/\(name.URLEscapedString)/repos"
    }
  }
  
  public var method: Moya.Method {
    return .GET
  }
  
  public var parameters: [String: AnyObject]? {
    switch self {
    case .UserRepositories(_):
      return ["sort": "pushed"]
    default:
      return nil
    }
  }
  
  //  public var multipartBody: [MultipartFormData]? {
  //    return nil
  //  }
  
  public var sampleData: NSData {
    switch self {
    case .UserProfile(let name):
      return "{\"login\": \"\(name)\", \"id\": 100}".dataUsingEncoding(NSUTF8StringEncoding)!
    case .UserRepositories(_):
      return "[{\"name\": \"Repo Name\"}]".dataUsingEncoding(NSUTF8StringEncoding)!
    }
  }
}
