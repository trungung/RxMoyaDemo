//
//  ViewController.swift
//  RxMoyaDemo
//
//  Copyright © 2016 rx.com.demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var repos = NSArray()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    downloadRepositories("ashfurrow")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - API Stuff
  
  func downloadRepositories(username: String) {
    GitHubProvider.request(.UserRepositories(username), completion: { result in
      
      var success = true
      var message = "Unable to fetch from GitHub"
      
      switch result {
      case let .Success(response):
        do {
          let json: NSArray? = try response.mapJSON() as? NSArray
          if let json = json {
            // Presumably, you'd parse the JSON into a model object. This is just a demo, so we'll keep it as-is.
            self.repos = json
          } else {
            success = false
          }
        } catch {
          success = false
        }
      //        self.tableView.reloadData()
      case let .Failure(error):
        guard let error = error as? CustomStringConvertible else {
          break
        }
        message = error.description
        success = false
      }
      
      if !success {
        let alertController = UIAlertController(title: "GitHub Fetch", message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
          alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(ok)
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    })
  }
}

