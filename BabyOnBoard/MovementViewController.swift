//
//  MovementViewController.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 01/09/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit

class MovementViewController: UIViewController {

  var selectedMovement:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  @IBAction func horizontalCribButtonAction(_ sender: Any) {
    self.selectedMovement = "horizontal"
    self.performSegue(withIdentifier: "toSchedule", sender: self)
  }
  
  @IBAction func verticalCribButtonAction(_ sender: Any) {
    self.selectedMovement = "vertical"
    self.performSegue(withIdentifier: "toSchedule", sender: self)
  }
    
  @IBAction func vibrateCribButtonAction(_ sender: Any) {
    self.selectedMovement = "vibrate"
    self.performSegue(withIdentifier: "toSchedule", sender: self)
  }

  @IBAction func cancelMovementAction(_ sender: Any) {
    print("CANCEL MOVEMENT")
  }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

      var destination = segue.destination as! ScheduleViewController
      destination.movementType = self.selectedMovement
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.


    }

}
