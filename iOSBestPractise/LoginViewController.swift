//
//  LoginViewController.swift
//  FxHunter
//
//  Created by TPCG II on 24/10/16.
//  Copyright © 2016 TPCG II. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var SignUpButton: UIButton!
   
    @IBOutlet weak var resendEmail: UIButton!
    
    
    let bottomBorder = CALayer()
    let bottomBorderPass = CALayer()
    //If you have not received verification link on your email,click here to Resend
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBorder()
        addKeyBoardobserver()
        attributedText()
      //  button.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.resendEmail.titleLabel?.text = "Forgot password?".localized
        self.resendEmail.titleLabel?.textAlignment = NSTextAlignment.center
        self.EmailText.delegate = self
        self.PasswordText.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        
        bottomBorder.frame = CGRect(x: 0, y: self.EmailText!.frame.height-1, width: self.EmailText!.frame.width, height: 1)
        bottomBorderPass.frame = CGRect(x: 0, y: self.PasswordText!.frame.height-1, width: self.PasswordText!.frame.width, height: 1)
        
        let device = UIDevice.init().type
        if device == Model.iPhone4S || device == Model.iPhone4 {
             self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 568)
        }else {
       
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        }
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "loginsignup" {
            let vc = segue.destination as! SignUpViewController
            vc.signUpDelegate = self
        }
    }
    
    // Hide keyboard when touching the screen
      
    @IBAction func tapAction(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUpButtonAction(_ sender: AnyObject) {
         self.performSegue(withIdentifier: "loginsignup", sender: self)
    }
    
    @IBAction func SignInButtonAction(_ sender: AnyObject) {
        
        self.performSignIn()
        
    }
    
    
    @IBAction func forgotAndResendButtonAction(_ sender: UIButton) {
       
        if sender.titleLabel?.text?.localized == "Forgot password?".localized{// forgot password screen
            //log.debug("Forgot password?")
            self.performSegue(withIdentifier: "loginForgot", sender: self)
        }else {// resend email
        
            //log.debug("resend email verfication")
        }
    }
    
    //MARK : Unwind Segue
    @IBAction func unwindToSignIn(segue: UIStoryboardSegue) {}
    
    @IBAction func unwindToForgotPassword(segue: UIStoryboardSegue) {}
    
    

    

}

extension LoginViewController {
    
    func addBorder(){
        
        bottomBorder.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.EmailText.layer.addSublayer(bottomBorder)
        
        bottomBorderPass.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.PasswordText.layer.addSublayer(bottomBorderPass)
    
        self.emailLabel.addCharactersSpacing(spacing: 5, text: "EMAIL".uppercased().localized)
        self.passwordLabel.addCharactersSpacing(spacing: 5, text: "PASSWORD".uppercased().localized)
       
    }
    
    func addKeyBoardobserver() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
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
    
    func attributedText(){
        // create attributed string
        let attributedString = NSMutableAttributedString(string:"Don't have an account? ".localized)
        let myString = "Sign Up".localized
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor(red: 194/255, green: 159/255, blue: 74/255, alpha: 1.0) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        attributedString.append(myAttrString)
       
        self.SignUpButton.setAttributedTitle(attributedString, for: .normal)
      
    }
    
    func performSignIn(){
        
        let email = self.EmailText.text
        let password = self.PasswordText.text
        
        do {
            if try email?.isEmail() == true {
                
                // if is valid email
                
                if password?.count == 0 {
                    showAlert(message: "Please type your password".localized)
                    self.PasswordText.becomeFirstResponder()
                    return
                }
                
            }
            else {
                showAlert(message: "Please type your e-mail in the correct format".localized)
                self.EmailText.becomeFirstResponder()
                return
            }
            
        } catch {
            
            //show error
            return
        }
        
        // if validated the credentials perform signin prosess
        
        //sign in completed
        let alert = UIAlertController.init(title: "Sucess", message: "login Sucess", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default) { (action) in
            UserDefaults.standard.set(true, forKey: "login")
            self.loggedIn()
            // self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    func loggedIn() {
      LoginHelper.showMainScreen(self)
    }
    
    func showAlert(message: String){
        // create the alert
       // let alert = UIAlertController(title: "Alert!", message: message , preferredStyle: UIAlertControllerStyle.alert)
        let alert = UIAlertController(title: nil, message: message , preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, text.count))
        self.attributedText = attributedString
    }
}

extension LoginViewController : UITextFieldDelegate {

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //log.info("TextField should return method called")
        switch textField {
         case self.PasswordText:
            self.performSignIn()
        case self.EmailText:
            self.PasswordText.becomeFirstResponder()
         default:
            //log.info("not clicked")
            break
        }
        
     
        return true
    }
}

extension LoginViewController : SignUpDelegate {
    
    
    
    

    func methodToUpdateButtonNameToResend(Email email : String) {
    
    
        //If you have not received verification link on your email,click here to Resend
        let attributedString = NSMutableAttributedString(string:"If you have not received verification link on your email,".localized)
        let myString = "click here to Resend".localized
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor(red: 194/255, green: 159/255, blue: 74/255, alpha: 1.0) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        attributedString.append(myAttrString)
        
        self.resendEmail.setAttributedTitle(attributedString, for: .normal)
        
        self.EmailText.text = email
        
        
    }
}
