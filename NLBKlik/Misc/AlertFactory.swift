//
//  AlertFactory.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/14/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class AlertFactory {
	static private var isLoginErrorPresented: Bool = false

	static func connectionError() -> UIAlertController {
		let alert = UIAlertController(title: "No internet connection available.", message: "Open Settings?", preferredStyle: UIAlertControllerStyle.Alert)
		let openSettingsAction = UIAlertAction(title: "Settings", style: .Default) { (alert) in
			UIApplication.sharedApplication().openURL(NSURL(string: "prefs:root=ROOT")!)
			// prefs:root=General&path=Music
		}
		let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
		alert.addAction(openSettingsAction)
		alert.addAction(defaultAction)

		return alert
	}

	static func connectionErrorIOS10() {
		if (!isLoginErrorPresented) {
			isLoginErrorPresented = true
			let notification = CWStatusBarNotification()
			notification.notificationLabelTextColor = .whiteColor()
			notification.notificationLabelBackgroundColor = .redColor()
			notification.displayNotificationWithMessage("No internet connection", forDuration: 3.0, complete: {
				isLoginErrorPresented = false
			})
		}
	}

	static func loginError() -> UIAlertController {
		let alert = UIAlertController(title: "Login error",
			message: "Please fill username and password fields with valid data",
			preferredStyle: UIAlertControllerStyle.Alert)

		let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
		alert.addAction(defaultAction)

		return alert
	}
}