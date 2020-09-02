//
//  WebViewController.swift
//  FxHunter
//
//  Created by amit sahu on 14/11/16.
//  Copyright © 2016 TPCG II. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    var theBool: Bool = Bool()
    
    var url: String = ""
    var webTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
   
        
       // webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        
        let url = NSURL(string: self.url)
        let request = NSURLRequest(url:url! as URL)
        webView.loadRequest(request as URLRequest)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white 
    
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(WebViewController.refreshAction))
        navigationItem.rightBarButtonItem = refreshButton
        
        self.navigationItem.title = self.webTitle
        
        //self.pleaseWait()
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //webViewDidStartLoad(webView)
    }
    override func viewDidDisappear(_ animated: Bool) {
        //self.clearAllNotice()
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
       // self.clearAllNotice()
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    @objc func refreshAction(){
        //self.pleaseWait()
        //pleaseWaitMBHUD(view: self.view)
        webView.reload()
    }
   

   
}
