//
//  UIApplication+Extra.swift
//  OFW
//
//  Created by Scott Puhl on 1/27/17.
//  Copyright © 2017 Avirat Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication
{
    /// EZSE: Get the top most view controller from the base view controller; default param is UIWindow's rootViewController
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
