//
//  AppDelegate.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 31/08/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else {
      print("Bould Not het Status Bar view")
      return true
    }
    statusBar.backgroundColor = UIColor(red: 201/237, green: 214/109, blue: 253/126, alpha: 1.0)
    return true
  }
}
