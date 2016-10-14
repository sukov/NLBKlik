//
//  AvailableFundsPresenterImp.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/5/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class AvailableFundsPresenterImp: AvailableFundsPresenter {
	weak private var view: AvailableFundsView?

	func attachView(view: AvailableFundsView) {
		guard NetworkManager.sharedInstance.isConnectedToNetwork() else {
			return
		}

		if (self.view == nil) {
			self.view = view
			view.animate(true)
			NetworkManager.sharedInstance.getAvailableFunds({ (transactionAcc, debitCards, success) in
				if (success) {
					view.showItems(transactionAcc!, debitCards: debitCards!)
				}
				view.animate(false)
			})
		}
	}

	func detachView(view: AvailableFundsView) {
		if (self.view === view) {
			self.view = nil
		}
	}

	func refresh() {
		guard NetworkManager.sharedInstance.isConnectedToNetwork() else {
			view?.showConnectionError()
			view?.resetButtons()
			return
		}

		guard NetworkManager.sharedInstance.checkIfSessionIsValid() else {
			view?.showLoginScreen()
			return
		}
		view?.animate(true)
		NetworkManager.sharedInstance.reloadWebPage {
			NetworkManager.sharedInstance.getAvailableFunds({ (transactionAcc, debitCards, success) in
				if (success) {
					self.view?.showItems(transactionAcc!, debitCards: debitCards!)
				}
				self.view?.animate(false)
			})

		}
	}
}