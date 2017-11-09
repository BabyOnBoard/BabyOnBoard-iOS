//
//  FirstViewController.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 31/08/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController{

  @IBOutlet weak var viewWebView: UIWebView!
  
  @IBOutlet weak var heartbeatLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var breathingLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.loadYoutube(videoID: "fpDXt6QNmBI")



  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc func loadYoutube(videoID:String) {
    guard
      let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
      else { return }
    viewWebView.loadRequest( URLRequest(url: youtubeURL) )
  }

  override func viewDidAppear(_ animated: Bool) {

//    updateTemperature()
  }
  
  @IBAction func statisticsButtonAction(_ sender: Any) {
    print("statistics Button Pressed")

//    self.heartbeatLabel.text = "123982732"
    updateTemperature()
    updateBreathing()
    updateHeartbeat()
  }


  //MARK:UpdateLabelsRequest
  func updateTemperature(){
    let success = { (result:AnyObject) -> Void in
      let json = result as! Dictionary<String,AnyObject>
      self.temperatureLabel.text = (json["temperature"] as? String ?? "--") + "ºC"
    }

    let error = { (result:NSError) -> Void in
      print("AWESOME ERROR \(result)")
    }
    ApiConnector.temperature(success: success, failure: error);
  }

  func updateBreathing(){
    let success = { (result:AnyObject) -> Void in
      let json = result as! Dictionary<String,AnyObject>
      let isBreathing = json["is_breathing"] as? Bool
      var labelText = ""

      if isBreathing == true {
        labelText = "Normal"
      } else {
        labelText = "Baixa"
      }
      self.breathingLabel.text = labelText

    }

    let error = { (result:NSError) -> Void in
      print("AWESOME ERROR \(result)")
    }
    ApiConnector.breathing(success: success, failure: error);
  }

  func updateHeartbeat(){
    let success = { (result:AnyObject) -> Void in
      let json = result as! Dictionary<String,AnyObject>
      let heartbeat = (json["beats"] as? Float ?? 0.0)


      self.heartbeatLabel.text = String(heartbeat ) + "bpm"
    }

    let error = { (result:NSError) -> Void in
      print("AWESOME ERROR \(result)")
    }
    ApiConnector.heartbeat(success: success, failure: error);
  }


}

