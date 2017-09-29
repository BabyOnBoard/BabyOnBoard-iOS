//
//  FirstViewController.swift
//  BabyOnBoard
//
//  Created by Felipe César Silveira de Assis on 31/08/17.
//  Copyright © 2017 Felipe César Silveira de Assis. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var viewWebView: UIWebView!
  
  let songs = ["Highway to Hell",
               "Simphony of Destruction",
               "Y.M.C.A",
               "Show Me How To Live",
               "Killing In The Name",
               "Back In Black",
               "Dani California"]
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.loadYoutube(videoID: "fpDXt6QNmBI")

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func loadYoutube(videoID:String) {
    guard
      let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
      else { return }
    viewWebView.loadRequest( URLRequest(url: youtubeURL) )
  }

  
  
  
  
  //MARK: TableViewDataSource
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return songs.count
  }
  
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = UITableViewCell.init(style: .default, reuseIdentifier: "simpleCell")
    
    cell.textLabel?.text = songs[indexPath.row]
    cell.imageView?.image = UIImage(named: "music.png")
    cell.backgroundColor = UIColor.init(red: 255, green: 237, blue:170, alpha: 0.5)
    cell.backgroundView?.backgroundColor = UIColor.init(red: 255, green: 237, blue:170, alpha: 0.5)
    cell.contentView.backgroundColor = UIColor.init(red: 255, green: 237, blue:170, alpha: 0.5)
    return cell
  }


}

