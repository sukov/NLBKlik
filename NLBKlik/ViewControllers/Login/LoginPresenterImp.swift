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

	init() {
		NetworkManager.sharedInstance.loadWebPage(nil)
	}

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
        guard NetworkManager.sharedInstance.isConnectedToNetwork() else {
            view?.showConnectionError()
            return
        }
        
		let username = userData[UserDataKeys.username] as? String ?? ""
		let password = userData[UserDataKeys.password] as? String ?? ""

		if (username.characters.count > 3 && password.characters.count > 3) {
			view?.animate(shouldAnimate: true)
			if (userData[UserDataKeys.rememberMe] as? Bool == true) {
				if let user = User(userData: userData) {
					saveUser(user)
				}
			}
			NetworkManager.sharedInstance.loadWebPage({ [weak self](success) in
				NetworkManager.sharedInstance.login(username, password: password, complete: { (success) in
					if (success) {
						self?.view?.animate(shouldAnimate: false)
						self?.view?.showNextScreen()
					} else {
						self?.view?.animate(shouldAnimate: false)
					}

				})
			})

		} else {
			view?.animate(shouldAnimate: false)
			view?.showLoginError()
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