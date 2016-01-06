//
//  HomeViewController.swift
//  skillz
//
//  Created by Florent Capon on 10/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import DeviceKit

class HomeViewController: UIViewController {
    @IBOutlet weak var backgroundImagaView: UIImageView!
    @IBOutlet weak var googleConnectButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Device() == .iPhone6) {
            self.backgroundImagaView.image = UIImage(named: "BackgroundSkillz~iphone6")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

