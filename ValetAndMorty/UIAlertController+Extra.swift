//
//  UIAlertController+Extra.swift
//  OFW
//
//  Created by Scott Puhl on 6/5/17.
//  Copyright © 2017 Avirat Inc. All rights reserved.
//

import UIKit
import AudioToolbox

extension UIAlertController
{
    /// SwifterSwift: Create new alert view controller with default OK action.
    ///
    /// - Parameters:
    ///   - title: alert controller's title.
    ///   - message: alert controller's message (default is nil).
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: alert controller's tint color (default is nil)
    public convenience init(title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
        if let color = tintColor {
            view.tintColor = color
        }
    }
    
    /// SwifterSwift: Create new error alert view controller from Error with default OK action.
    ///
    /// - Parameters:
    ///   - title: alert controller's title (default is "Error").
    ///   - error: error to set alert controller's message to it's localizedDescription.
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: alert controller's tint color (default is nil)
    public convenience init(title: String = "Error", error: Error, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
        self.init(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
        if let color = tintColor {
            view.tintColor = color
        }
    }
    
    public func show(animated: Bool = true, vibrate: Bool = false, completion: (() -> Void)? = nil)
    {
        if let topmost = UIApplication.topViewController()
        {
            topmost.present(self, animated: true, completion: nil)
        }
        
        if vibrate
        {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
    
    static func twoChoices( title:String?,
                            message:String?,
                            choice1name:String,
                            choice2name:String,
                            choice1action:@escaping()->Void,
                            choice2action:@escaping()->Void )
    {
        //prompt to save
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let choice1Action = UIAlertAction(title: choice1name, style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            choice1action()
        }
        
        let choice2Action = UIAlertAction(title: choice2name, style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            choice2action()
        }
        
        alertController.addAction(choice1Action)
        alertController.addAction(choice2Action)
        
        
        if let topmost = UIApplication.topViewController()
        {
            topmost.present(alertController, animated: true, completion: nil)
        }
    }
}
