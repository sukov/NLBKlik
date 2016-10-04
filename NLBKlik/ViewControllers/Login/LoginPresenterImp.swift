//
//  LoginPresenterImp.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class LoginPresenterImp: LoginPresenter {
	weak private var view: LoginView?
	let userDefaults = NSUserDefaults.standardUserDefaults()

	func attachView(view: LoginView) {
		if (self.view == nil) {
			self.view = view
			if let user = loadUser() {
				view.setContent(user)
			}
		}
	}

	func detachView(view: LoginView) {
		if (self.view === view) {
			self.view = nil
		}
	}

	func login(userData: [String: AnyObject]) {
		let username = userData[UserDataKeys.username] as? String ?? ""
		let password = userData[UserDataKeys.password] as? String ?? ""

		if (username.characters.count > 3 && password.characters.count > 3) {
			view?.animate(shouldAnimate: true)
			if (userData[UserDataKeys.rememberMe] as? Bool == true) {
				if let user = User(userData: userData) {
					saveUser(user)
				}
			}
		} else {
			view?.showErrorAlert()
		}
	}

	private func saveUser(user: User) {
		let encodedData = NSKeyedArchiver.archivedDataWithRootObject(user)
		userDefaults.setObject(encodedData, forKey: "user")
		userDefaults.synchronize()
	}

	private func loadUser() -> User? {
		let decoded = userDefaults.objectForKey("user") as? NSData
		return (decoded != nil) ? (NSKeyedUnarchiver.unarchiveObjectWithData(decoded!) as? User) : nil
	}
}