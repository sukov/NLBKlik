//
//  LoginView.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

@objc protocol LoginView {
	func setContent(user: User)
	func animate(shouldAnimate animate: Bool)
	func showNextScreen()
	func showLoginError()
    func showConnectionError()
}