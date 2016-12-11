//
//  UILabel.swift
//  NLBKlik
//
//  Created by Sukov on 10/8/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

extension UILabel {
    
    public func enableCopyMenu() {
        userInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(UILabel.showMenu(_:))))
    }
    
    func showMenu(sender: AnyObject?) {
        becomeFirstResponder()
        let menu = UIMenuController.sharedMenuController()
        if !menu.menuVisible {
            menu.setTargetRect(bounds, inView: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    
    override public func copy(sender: AnyObject?) {
        let board = UIPasteboard.generalPasteboard()
        board.string = text?.toDigits()
        let menu = UIMenuController.sharedMenuController()
        menu.setMenuVisible(false, animated: true)
    }
    
    override public func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override public func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(copy(_:)) {
            return true
        }
        return false
    }
}
