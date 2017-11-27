//
//  TabBarControllerViewController.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 31/08/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

    let tabViewControllers = tabBarController.viewControllers!
    guard let toIndex = tabViewControllers.index(of: viewController) else {
      return false
    }

    // Our method
    animateToTab(toIndex: toIndex)

    return true
  }

  @objc func animateToTab(toIndex: Int) {

    let tabViewControllers = viewControllers!
    let fromView = selectedViewController!.view
    let toView = tabViewControllers[toIndex].view
    let fromIndex = tabViewControllers.index(of: selectedViewController!)

    guard fromIndex != toIndex else {return}

    // Add the toView to the tab bar view
    fromView?.superview!.addSubview(toView!)

    // Position toView off screen (to the left/right of fromView)
    let screenWidth = UIScreen.main.bounds.size.width
    let scrollRight = toIndex > fromIndex!
    let offset = (scrollRight ? screenWidth : -screenWidth)
    toView?.center = CGPoint(x: (fromView?.center.x)! + offset, y: (toView?.center.y)!)

    // Disable interaction during animation
    view.isUserInteractionEnabled = false

    UIView.animate(withDuration: 0.5,
                   delay: 0.0,
                   usingSpringWithDamping: 1,
                   initialSpringVelocity: 0,
                   options: UIViewAnimationOptions.curveEaseOut,
                   animations: {

      // Slide the views by -offset
      fromView?.center = CGPoint(x: (fromView?.center.x)! - offset, y: (fromView?.center.y)!)
      toView?.center   = CGPoint(x: (toView?.center.x)! - offset, y: (toView?.center.y)!)

    }, completion: { _ in

      // Remove the old view from the tabbar view.
      fromView?.removeFromSuperview()
      self.selectedIndex = toIndex
      self.view.isUserInteractionEnabled = true
    })
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
