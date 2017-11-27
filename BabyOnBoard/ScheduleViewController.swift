//
//  ScheduleViewController.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 01/09/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

  @IBOutlet weak var datePicker: UIDatePicker!

  var movementType: String = ""

  override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.backgroundColor = UIColor(red: 201/255, green: 214/255.0, blue: 253/255, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

  @IBAction func initButtonAction(_ sender: Any) {
    let secontsKeepMooving = datePicker.countDownDuration

    print("MOVEMENT Type \(self.movementType) >> secondas \(secontsKeepMooving)")

    let success = { (result: AnyObject) -> Void in

    }

    let error = { (result: NSError) -> Void in
      if result.code == 4 {
        self.dismiss(animated: true, completion: nil)
        return
      }
      print("HOUVE UM ERRO")
    }

    ApiConnector.movement(type: self.movementType,
                          duration: Int(secontsKeepMooving),
                          success: success,
                          failure: error)
  }

  @IBAction func cancelButtonAction(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
