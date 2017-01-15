//
//  HomeViewController.swift
//  skillz
//
//  Created by Florent Capon on 10/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import DeviceKit

class HomeViewController: UIViewController, UIAlertViewDelegate {
    @IBOutlet weak var backgroundImagaView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Device() == .iPhone6) {
            self.backgroundImagaView.image = UIImage(named: "BackgroundSkillz~iphone6")
        }
        
        self.startButton.setTitle(i18n("welcome").uppercased(), for: UIControlState())
    }
}
