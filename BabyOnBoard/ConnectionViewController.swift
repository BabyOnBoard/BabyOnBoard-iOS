//
//  ConnectionViewController.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 01/09/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit

class ConnectionViewController: UIViewController {

  @IBOutlet weak var addressTextField: UITextField!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func searchCribAction(_ sender: Any) {
    UserDefaults.standard.setValue(self.addressTextField.text ?? "", forKey: "crib_ip")
    self.addressTextField.resignFirstResponder()
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
