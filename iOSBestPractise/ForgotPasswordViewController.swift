//
//  ForgotPasswordViewController.swift
//  FxHunter
//
//  Created by amit sahu on 12/11/16.
//  Copyright © 2016 TPCG II. All rights reserved.
//

import UIKit


class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailLabel: UILabel!
    let bottomBorder = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorder()
        addKeyBoardobserver()
        
        self.emailText.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        
        bottomBorder.frame = CGRect(x: 0, y: self.emailText!.frame.height-1, width: self.emailText!.frame.width, height: 1)
       
        let device = UIDevice.init().type
        if device == Model.iPhone4S || device == Model.iPhone4 {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 568)
        }else {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
       self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func sendButtonAction(_ sender: AnyObject) {
        
       self.performForgotPassword()
        
    }
    
    @IBAction func backToSignInAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "unwindLoginForgot", sender: self)

    }

    @IBAction func tapAction(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func performForgotPassword(){
        
        do{
            
            if try emailText.text?.isEmail() == true {
                
                

                //sucess
                
            }else {
                
                
                self.showAlert(message: "Please type your e-mail in the correct format.".localized , action: nil)
                
            }
        }catch {
            
            return
        }
    }
}

extension ForgotPasswordViewController {

    func addBorder(){
        
        bottomBorder.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.emailText.layer.addSublayer(bottomBorder)
        
       
        
        self.emailLabel.addCharactersSpacing(spacing: 5, text: "EMAIL".uppercased())
       
        
    }
    
    fileprivate func showAlert(message: String , action : UIAlertAction?){
        // create the alert
       // let alert = UIAlertController(title: "Alert!", message: message , preferredStyle: UIAlertControllerStyle.alert)
        let alert = UIAlertController(title: "Message", message: message , preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        if action == nil {
        
            let daction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
 
        
            })
            alert.addAction(daction)
        }else {
        
            alert.addAction(action!)
        }
        
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func addKeyBoardobserver() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            self.scrollView.contentInset = UIEdgeInsets.zero
        } else {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
        //CGPoint point = textfield.frame.origin
        //scrollView.contentOffset = point
        //let selectedRange = self.scrollView.selectedRange
        //self.scrollView.scrollRangeToVisible(selectedRange)
    }

    
}

extension ForgotPasswordViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // log.info("TextField should return method called")
        switch textField {
        case self.emailText:
            self.performForgotPassword()
            // log.debug("clicked")
            break
        
        default:
            //  log.info("not clicked")
            break
        }
        
        
        return true
    }

}
