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

  var movementType:String = ""
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  @IBAction func initButtonAction(_ sender: Any) {
    let secontsKeepMooving = datePicker.countDownDuration

    print("MOVEMENT Type \(self.movementType) >> secondas \(secontsKeepMooving)")

    so
    //TODO: send the request to start movement
  }

  @IBAction func cancelButtonAction(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
