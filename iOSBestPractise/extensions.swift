//
//  extensions.swift
//  iOSBestPractise
//
//  Created by ajay singh thakur on 08/06/17.
//  Copyright © 2017 ajay singh thakur. All rights reserved.
//

import UIKit
import SafariServices
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
extension String {
    
    func isEmail() throws -> Bool {
        let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
    }
    
    func isValidPhoneNo() throws -> Bool {
        
        let regex = try NSRegularExpression(pattern: "[0-9]", options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
    }
}
extension String {
    var localized: String {
        //🖕Fuck the translators team, they don’t deserve comments
        return NSLocalizedString(self, comment: "")
    }
}
extension UIViewController : SFSafariViewControllerDelegate {
    
    
    
    public func safariViewControllerDidFinish(controller: SFSafariViewController){
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    public func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool){
        
        if didLoadSuccessfully == false {
            //controller.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
    }
    
}



