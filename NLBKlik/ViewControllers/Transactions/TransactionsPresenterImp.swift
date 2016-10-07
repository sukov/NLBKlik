//
//  TransactionsPresenterImp.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class TransactionsPresenterImp: TransactionsPresenter {
	weak private var view: TransactionsView?
	private var currentPage: Int = 1 {
		didSet(newVal) {
			if (newVal > pageCount) {
				view?.enableInfiniteScroll(false)
			}
		}
	}
	private var pageCount: Int? {
		didSet(newVal) {
			if (newVal != nil) {
				view?.enableInfiniteScroll(true)
			}
		}
	}

	func attachView(view: TransactionsView) {
		if (self.view == nil) {
			self.view = view
			NetworkManager.sharedInstance.getTransactions({ (items, pageCount, success) in
				if (success) {
					self.pageCount = pageCount
					view.showItems(items!)
				}
			})

		}
	}

	func detachView(view: TransactionsView) {
		if (view === view) {
			self.view = nil
			pageCount = nil
		}
	}

	func loadNew() {
		currentPage += 1
		if (currentPage <= pageCount) {
			NetworkManager.sharedInstance.getTransactions({ (items, _, success) in
				if (success) {
					self.view?.showItems(items!)
				}
			})
		}
	}
}