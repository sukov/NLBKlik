//
//  ReservedFundsPresenterImp.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class ReservedFundsPresenterImp: ReservedFundsPresenter {
	weak private var view: ReservedFundsView?

	func attachView(view: ReservedFundsView) {
		if (self.view == nil) {
			self.view = view
            NetworkManager.sharedInstance.getTransactions(complete: { (items, pageCount, success) in
				if (success) {
					view.showItems(items!)
				}
			})

		}
	}

	func detachView(view: ReservedFundsView) {
		if (view === view) {
			self.view = nil
		}
	}
}