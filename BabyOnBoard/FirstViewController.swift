//
//  FirstViewController.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 31/08/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

  @IBOutlet weak var viewWebView: UIWebView!
  @IBOutlet weak var heartbeatLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var breathingLabel: UILabel!

  var isVisible: Bool = false

  var noiseTimer: Timer = Timer.init()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.loadYoutube(videoID: "fpDXt6QNmBI")

    self.viewWebView.alpha = 0

    Timer.scheduledTimer(timeInterval: 5.0,
                         target: self,
                         selector: #selector(FirstViewController.updateAllValues),
                         userInfo: nil,
                         repeats: true)

    self.noiseTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
      self.checkNoise()
    }

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @objc func loadYoutube(videoID: String) {

    let address = UserDefaults.standard.string(forKey: "crib_ip") ?? ""
    guard
      let youtubeURL = URL(string: "http://"+address+":8081")
      else { return }
    viewWebView.loadRequest( URLRequest(url: youtubeURL) )
  }

  override func viewDidAppear(_ animated: Bool) {
    self.isVisible = true
    delay(0.2) {
      self.updateWebViewFrame()
      UIView.animate(withDuration: 0.3,
                                 delay: 0,
                                 animations: {
                                  self.viewWebView.alpha = 1.0
      },
                                 completion: nil)
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.isVisible = false;
  }

  @IBAction func statisticsButtonAction(_ sender: Any) {
    print("statistics Button Pressed")

    self.temperatureLabel.text = "........."
    self.breathingLabel.text = "........."
    self.heartbeatLabel.text = "........."

    self.view.isUserInteractionEnabled = false
    updateWebViewFrame()
    delay(2.0) {
      self.view.isUserInteractionEnabled = true
      self.updateTemperature()
      self.updateBreathing()
      self.updateHeartbeat()
    }

  }

  // MARK: UpdateLabelsRequest
  func updateTemperature() {
    let success = { (result: AnyObject) -> Void in
      let json = result as? [String: AnyObject] ?? [:]
      self.temperatureLabel.text = (json["temperature"] as? String ?? "--") + "ºC"
    }

    let error = { (result: NSError) -> Void in
      print("AWESOME ERROR \(result)")
    }
    ApiConnector.temperature(success: success, failure: error)
  }

  func updateBreathing() {
    let success = { (result: AnyObject) -> Void in
      let json = result as? [String: AnyObject] ?? [:]
      let isBreathing = json["is_breathing"] as? Bool
      var labelText = ""

      if isBreathing == true {
        labelText = "Normal"
      } else {
        labelText = "Baixa"
      }
      self.breathingLabel.text = labelText

    }

    let error = { (result: NSError) -> Void in
      print("AWESOME ERROR \(result)")
    }
    ApiConnector.breathing(success: success, failure: error)
  }

  func updateHeartbeat() {
    let success = { (result: AnyObject) -> Void in
      let json = result as? [String: AnyObject] ?? [:]
      let heartbeat = (json["beats"] as? Float ?? 0.0)
      self.heartbeatLabel.text = String(heartbeat ) + "bpm"
    }

    let error = { (result: NSError) -> Void in
      print("AWESOME ERROR \(result)")
    }
    ApiConnector.heartbeat(success: success, failure: error)
  }

  @objc func updateAllValues() {
    updateWebViewFrame()
    self.updateTemperature()
    self.updateBreathing()
    self.updateHeartbeat()
//    print("timer \(Date())")
  }

  // MARK: Utilities
  func delay(_ delay: Double, closure: @escaping () -> Void) {
    let when = DispatchTime.now() + 1.5

    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
  }

  func updateWebViewFrame() {

    let contentSize = viewWebView.scrollView.contentSize
    let viewSize = viewWebView.bounds.size
    viewWebView.contentMode = .scaleAspectFit
    viewWebView.scrollView.contentMode = .scaleAspectFit
    viewWebView.scrollView.bounces = false
    viewWebView.scrollView.isScrollEnabled = false

    if #available(iOS 11.0, *) {
      viewWebView.scrollView.contentInsetAdjustmentBehavior = .never
    } else {
      // Fallback on earlier versions
    }

    viewWebView.scrollView.contentSize = viewSize
    let rw = viewSize.width / contentSize.width

    viewWebView.scrollView.minimumZoomScale = rw
    viewWebView.scrollView.maximumZoomScale = rw
    viewWebView.scrollView.zoomScale = rw
  }

  func checkNoise() {
    let success = { (result: AnyObject) -> Void in
      let isCrying = result["is_crying"] as? Bool ?? false
//      print("CRY: \(String(describing: isCrying))")
      if self.isVisible && isCrying == true {
        self.presentAlert()
      }
    }

    let error = { (result: NSError) -> Void in
      print("ERROR:There was an error while getting noise")
    }

    if self.isVisible {
      ApiConnector.noise(success: success, failure: error)
    }
  }

  func presentAlert() {

    let snooze = { (action: UIAlertAction) in
      self.noiseTimer.invalidate(); // Deactivate old timer

      //activate old timer after 5 min
      Timer.scheduledTimer(withTimeInterval: 300, repeats: false, block: { _ in
        self.noiseTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
          self.checkNoise()
        }
      })
    }

    let deactivateAlarm = { (action: UIAlertAction) in
      self.noiseTimer.invalidate()
    }

    let alert = UIAlertController(title: "Alerta de Choro",
                                  message: "Detectamos um barulho incomum no quarto," +
                                  " verifique se o bebê está acordado.",
                                  preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Soneca!", style: UIAlertActionStyle.default, handler: snooze))
    alert.addAction(UIAlertAction(title: "Parar!", style: UIAlertActionStyle.default, handler: deactivateAlarm))

    self.present(alert, animated: true, completion: nil)
  }

}








