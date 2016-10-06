//
//  MainAssembly.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation
import UIKit

class MainAssembly {
	static let sharedInstance = MainAssembly()

	// Login
	func getLoginPresenter() -> LoginPresenter {
		return LoginPresenterImp()
	}

	func getLoginController() -> LoginController {
		return LoginController(presenter: MainAssembly.sharedInstance.getLoginPresenter())
	}

	// Menu
	func getMenuPresenter() -> MenuPresenter {
		return MenuPresenterImp()
	}

	func getMenuController() -> MenuController {
		return MenuController(presenter: MainAssembly.sharedInstance.getMenuPresenter())
	}

	// AvailableFunds
	func getAvailableFundsPresenter() -> AvailableFundsPresenter {
		return AvailableFundsPresenterImp()
	}

	func getAvailableFundsController() -> UIViewController {
		return UINavigationController(rootViewController: AvailableFundsController(presenter: MainAssembly.sharedInstance.getAvailableFundsPresenter()))
	}

	// Main
	func getMainController() -> MainController {
		let mainController = MainController(rearViewController: MainAssembly.sharedInstance.getMenuController(), frontViewController: MainAssembly.sharedInstance.getAvailableFundsController())
		return mainController
	}
}