//
//  SignUpViewController.swift
//  FxHunter
//
//  Created by amit sahu on 25/10/16.
//  Copyright © 2016 TPCG II. All rights reserved.
//

import UIKit
import SafariServices



protocol SignUpDelegate : class {
    func methodToUpdateButtonNameToResend(Email email : String)
}

class SignUpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var middleNameLabel: UILabel!
    @IBOutlet weak var middleNameText: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var mobileNoLabel: UILabel!
    @IBOutlet weak var mobileNoText: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var idNoLabel: UILabel!
    @IBOutlet weak var idNoText: UITextField!
    
    let bottomBorder = CALayer()
    let bottomBorderPass = CALayer()
    let bottomBorderFName = CALayer()
    let bottomBorderMName = CALayer()
    let bottomBorderLName = CALayer()
    let bottomBorderMNo = CALayer()
    let bottomBorderCountry = CALayer()
    let bottomBorderIDNo = CALayer()
    
    var countryCodeLabel : UILabel!
    
    var isChecked: Bool = false
    weak var signUpDelegate : SignUpDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addBorder()
        addKeyBoardobserver()
        attributedText()
        attributedTextTerms()
        
        self.firstNameText.delegate = self
        self.lastNameText.delegate = self
        self.middleNameText.delegate = self
        self.EmailText.delegate = self
        self.PasswordText.delegate = self
        self.mobileNoText.delegate = self
        self.countryText.delegate = self
        self.idNoText.delegate = self
        
        definesPresentationContext = true
        
       
        self.countryCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: self.mobileNoText.frame.height))
        self.countryCodeLabel.text = "+65"
        self.countryCodeLabel.textColor = UIColor.init(hexString: "#A4A4A4ff")
        self.countryCodeLabel.font = self.countryCodeLabel.font.withSize(14.0)
        mobileNoText.leftView = self.countryCodeLabel
        
        mobileNoText.leftViewMode = UITextField.ViewMode.always
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        
        bottomBorder.frame = CGRect(x: 0, y: self.EmailText!.frame.height-1, width: self.EmailText!.frame.width, height: 1)
        
        bottomBorderPass.frame = CGRect(x: 0, y: self.PasswordText!.frame.height-1, width: self.PasswordText!.frame.width, height: 1)
        
        bottomBorderFName.frame = CGRect(x: 0, y: self.firstNameText!.frame.height-1, width: self.firstNameText!.frame.width, height: 1)
        
        bottomBorderMName.frame = CGRect(x: 0, y: self.middleNameText!.frame.height-1, width: self.middleNameText!.frame.width, height: 1)
        
        bottomBorderLName.frame = CGRect(x: 0, y: self.lastNameText!.frame.height-1, width: self.lastNameText!.frame.width, height: 1)
        
        bottomBorderMNo.frame = CGRect(x: 0, y: self.middleNameText!.frame.height-1, width: self.middleNameText!.frame.width, height: 1)
        
        bottomBorderCountry.frame = CGRect(x: 0, y: self.countryText!.frame.height-1, width: self.countryText!.frame.width, height: 1)
        
        bottomBorderIDNo.frame = CGRect(x: 0, y: self.idNoText!.frame.height-1, width: self.idNoText!.frame.width, height: 1)
        
    
        let device = UIDevice.init().type
        if device == Model.iPhone4S || device == Model.iPhone4 {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 568)
        }else {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        }
      
    }
    
    // Hide keyboard when touching the screen
    
    @IBAction func tapAction(_ sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func signInAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "unwindSignupLogin", sender: self)
    }
    
    @IBAction func SignUpButtonAction(_ sender: AnyObject) {
        self.performSignUp()
    }
    func performSignUp(){
        let first = self.firstNameText.text
        let middle = self.middleNameText.text
        let last = self.lastNameText.text
        let email = self.EmailText.text
        let password = self.PasswordText.text
        let mobile = self.mobileNoText.text
        // let country = self.countryText.text
        // let idno = self.idNoText.text
        
        if first?.count == 0 {
            self.firstNameText.becomeFirstResponder()
            self.showAlert(message: "Please type your first name".localized)
            return
            
        }else if middle?.count == 0 {
        
            self.middleNameText.becomeFirstResponder()
            self.showAlert(message: "Please type your middle name".localized)
            return
        }else if last?.count == 0 {
            self.lastNameText.becomeFirstResponder()
            self.showAlert(message: "Please type your last name".localized)
            return
            
        }

        
        do {
            if try email?.isEmail() == true {
                
                // if is valid email
               if password?.count == 0 {
                    self.PasswordText.becomeFirstResponder()
                    self.showAlert(message: "Please type your password".localized)
                    return
                }else if (password?.count)! < 5 {
                    self.PasswordText.becomeFirstResponder()
                    self.showAlert(message: "Passwords must be at least 5 characters long".localized)
                    return
                }
                
            }
            else {
                self.EmailText.becomeFirstResponder()
                self.showAlert(message: "Please type your e-mail in the correct format".localized)
                return
            }
            
        } catch {
            
            //show error
            return
        }
        
        
        do {
            if try mobile?.isValidPhoneNo() == true{
                
                /*if (mobile?.characters.count)! != 10 {
                    self.mobileNoText.becomeFirstResponder()
                    self.showAlert(message: "Please type your valid mobile no")
                    return
                }
                else*/
                /*if country?.characters.count == 0 {
                    self.countryText.becomeFirstResponder()
                    self.showAlert(message: "Please type your country")
                    return
                }*/
                
                /*else if idno?.characters.count == 0 {
                    self.idNoText.becomeFirstResponder()
                    self.showAlert(message: "Please type your identification no")
                    return
                }*/
                if self.isChecked == false{
                    self.showAlert(message: "Please check the Terms of Use checkbox to complete Sign Up process".localized)
                    return
                }
            }else if  mobile?.count != 0 {
                self.mobileNoText.becomeFirstResponder()
                self.showAlert(message: "Please type a valid mobile no.".localized)
                return
            }
        
        } catch {
            
           
            //show error
            return
        }
        
        if mobile?.count == 0 {
           if self.isChecked == false{
                self.showAlert(message: "Please check the Terms of Use checkbox to complete Sign Up process".localized)
                return
            }
        }
        
        // if validated the credentials perform signin prosess
     
        //sucess
    }
    
    @IBAction func checkBoxButtonAction(_ sender: AnyObject) {
        
        if self.isChecked == false{

            let checked: UIImage = UIImage(named: "mark-checked")!
            self.checkBoxButton.setImage(checked, for: .normal)
            self.isChecked = true
        }else if self.isChecked == true{
            let unchecked: UIImage = UIImage(named: "mark-unchecked")!
            self.checkBoxButton.setImage(unchecked, for: .normal)
            self.isChecked = false
        }
        
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "signUptoWeb" {
            let vc = segue.destination as! WebViewController
            //vc.webv = self
            vc.webTitle = "Terms of Use"
            vc.url = "http://ec2-52-220-176-130.ap-southeast-1.compute.amazonaws.com/terms.html"//"http://mt4db.tk/terms.html"
        }
    }
    
    @IBAction func termsButtonAction(_ sender: AnyObject) {
        
        //let url: String = "http://mt4db.tk/terms.html";
        
        self.performSegue(withIdentifier: "signUptoWeb", sender: self)
        
        /*if let url = NSURL(string: url) {
            let vc = SFSafariViewController(url: url as URL, entersReaderIfAvailable: true)
            vc.delegate = self
            vc.modalPresentationStyle = .overFullScreen
            vc.view.tintColor = UIColor.black
            vc.navigationController?.navigationBar.barTintColor = UIColor.black
            
            self.present(vc, animated: true, completion: {
                vc.navigationController?.navigationBar.barStyle = .black
            })
        }*/
    }
   
    
    
}

extension SignUpViewController {
    
    func addBorder(){
        
        bottomBorder.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.EmailText.layer.addSublayer(bottomBorder)
        
        bottomBorderPass.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.PasswordText.layer.addSublayer(bottomBorderPass)
        
        bottomBorderFName.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.firstNameText.layer.addSublayer(bottomBorderFName)
        
        bottomBorderMName.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.middleNameText.layer.addSublayer(bottomBorderMName)
        
        bottomBorderLName.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.lastNameText.layer.addSublayer(bottomBorderLName)
        
        bottomBorderMNo.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.mobileNoText.layer.addSublayer(bottomBorderMNo)
        
        bottomBorderCountry.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.countryText.layer.addSublayer(bottomBorderCountry)
        
        bottomBorderIDNo.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.3).cgColor
        self.idNoText.layer.addSublayer(bottomBorderIDNo)
        
        
        self.emailLabel.addCharactersSpacing(spacing: 5, text: "EMAIL".localized)
        self.passwordLabel.addCharactersSpacing(spacing: 5, text: "PASSWORD".localized)
        self.firstNameLabel.addCharactersSpacing(spacing: 5, text: "FIRST NAME".localized)
        self.middleNameLabel.addCharactersSpacing(spacing: 5, text: "MIDDLE NAME".localized)
        self.lastNameLabel.addCharactersSpacing(spacing: 5, text: "LAST NAME".localized)
        self.mobileNoLabel.addCharactersSpacing(spacing: 5, text: "MOBILE NO".localized)
        self.countryLabel.addCharactersSpacing(spacing: 5, text: "COUNTRY".localized)
        self.idNoLabel.addCharactersSpacing(spacing: 5, text: "IDENTIFICATION NO".localized)

        
    }
    
    func addKeyBoardobserver() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name:UIResponder.keyboardWillHideNotification, object: nil)
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
        let attributedString = NSMutableAttributedString(string:"Already have an account? ".localized)
        let myString = "Sign In".localized
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor(red: 194/255, green: 159/255, blue: 74/255, alpha: 1.0) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        attributedString.append(myAttrString)
        
        self.SignUpButton.setAttributedTitle(attributedString, for: .normal)
        
    }
    
    func attributedTextTerms(){
        // create attributed string
        let attributedString = NSMutableAttributedString(string:"I agree to the ".localized)
        let myString = "Terms of Use".localized
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor(red: 194/255, green: 159/255, blue: 74/255, alpha: 1.0) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        attributedString.append(myAttrString)
        
        self.termsButton.setAttributedTitle(attributedString, for: .normal)
        
    }
    
    func showAlert(message: String){
        // create the alert
        //var messageTitle = "Alert!"
        
        if message == "Please check your email for the verification".localized {
            //messageTitle = "Success"
        }
        let alert = UIAlertController(title: nil, message: message , preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)

        let action = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: { (action) in
            
            if message == "Please check your email for the verification".localized{
                self.performSegue(withIdentifier: "unwindSignupLogin", sender: self)
            }
            
            
        })
        alert.addAction(action)
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}

extension SignUpViewController : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //log.info("TextField should return method called")
        switch textField {
        case self.firstNameText:
            self.middleNameText.becomeFirstResponder()
            break
        case self.middleNameText:
            self.lastNameText.becomeFirstResponder()
            break
        case self.lastNameText:
            self.EmailText.becomeFirstResponder()
            break
        case self.EmailText:
            self.PasswordText.becomeFirstResponder()
            break
        case self.PasswordText:
            //self.countryText.becomeFirstResponder()
            break
        case self.mobileNoText:
            self.idNoText.becomeFirstResponder()
            break
        case self.idNoText:
            self.performSignUp()
        case self.countryText:
            self.mobileNoText.becomeFirstResponder()
            break
        default:
            //print something
            break
        }
        
        
        return true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.countryText {
        
//            let viewController = CountryPickerViewController()
//            viewController.delegate = self
//            viewController.showsCallingCodes = true
//            log.debug("The current country is \(viewController.currentCountry)".localized)
//            
//            let navigationController = UINavigationController(rootViewController: viewController)
//            present(navigationController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
}



