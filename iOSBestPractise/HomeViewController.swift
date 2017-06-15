//
//  HomeViewController.swift
//  iOSBestPractise
//
//  Created by ajay singh thakur on 09/06/17.
//  Copyright © 2017 ajay singh thakur. All rights reserved.
//

import UIKit
import Crashlytics
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func crashButtonAction(_ sender : UIButton){
    
        Crashlytics.sharedInstance().crash()
    }

}
