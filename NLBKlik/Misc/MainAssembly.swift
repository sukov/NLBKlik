//
//  MainAssembly.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class MainAssembly {
	static let sharedInstance = MainAssembly()

	// Login
	func getLoginPresenter() -> LoginPresenter {
		return LoginPresenterImp()
	}

	func getLoginController() -> LoginController {
		return LoginController(presenter: MainAssembly.sharedInstance.getLoginPresenter())
	}
}