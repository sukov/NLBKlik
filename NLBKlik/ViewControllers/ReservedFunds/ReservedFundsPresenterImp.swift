//
//  ReservedFundsPresenterImp.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class ReservedFundsPresenterImp: TransactionsPresenter {
	weak private var view: TransactionsView?
	private var currentPage: Int = 1 {
		didSet {
			if (currentPage >= pageCount) {
				view?.showNextPageButton(false)
			}
		}
	}
	private var pageCount: Int? {
		didSet {
			if (pageCount != nil && pageCount > 1) {
				view?.showNextPageButton(true)
			}
		}
	}

	func attachView(view: TransactionsView) {
		if (self.view == nil) {
			self.view = view
			view.navigationBarTitle("Reserved funds")

			guard NetworkManager.sharedInstance.isConnectedToNetwork() else {
				return
			}
			guard NetworkManager.sharedInstance.checkIfSessionIsValid() else {
				view.showLoginScreen()
				return
			}
			view.animate(true)
			NetworkManager.sharedInstance.getReservedFunds(complete: { (items, pageCount, success) in
				if (success) {
					self.pageCount = pageCount
					view.showItems(items!)
				}
				view.animate(false)
			})
		}
	}

	func detachView(view: TransactionsView) {
		if (view === view) {
			self.view = nil
			pageCount = nil
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
			NetworkManager.sharedInstance.getReservedFunds(complete: { (items, pageCount, success) in
				if (success) {
					self.currentPage = 1
					self.pageCount = pageCount
					self.view?.showItems(items!)
				} else {
					self.view?.showNextPageButton(false)
					self.view?.resetButtons()
				}
				self.view?.animate(false)
			})
		}
	}

	func loadNextPage() {
		currentPage += 1
		guard NetworkManager.sharedInstance.checkIfSessionIsValid() else {
			view?.showLoginScreen()
			view?.resetButtons()
			return
		}
		if (currentPage <= pageCount) {
			NetworkManager.sharedInstance.getReservedFunds(true, complete: { (items, _, success) in
				if (success) {
					self.view?.showItems(items!)
				}
			})
		}
	}
}