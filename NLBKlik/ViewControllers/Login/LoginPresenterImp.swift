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

	func attachView(view: LoginView) {
		if (self.view == nil) {
			self.view = view
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

		} else {
			view?.showErrorAlert()
		}
	}
}