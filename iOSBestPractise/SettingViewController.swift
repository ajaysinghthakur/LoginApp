//
//  ViewController.swift
//  iOSBestPractise
//
//  Created by ajay singh thakur on 08/06/17.
//  Copyright © 2017 ajay singh thakur. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController {

    fileprivate let titles = ["Privacy policy","Terms of use","Share this app"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}
extension SettingViewController : UITableViewDelegate {


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section , indexPath.row) {
        case (0,_):
            break
            
        case(1,_):// logout here
            UserDefaults.standard.set(false, forKey: "login")
            LoginHelper.showLoginScreen(self)
            break
            
        default:
            break
        }
    }
    
}
extension SettingViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [3,1][section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = titles[indexPath.row]
            return cell
        }else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "lcell", for: indexPath)
            return cell
            
        }
        
    }
}

