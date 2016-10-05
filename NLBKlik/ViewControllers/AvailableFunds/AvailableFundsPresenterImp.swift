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
		if (self.view == nil) {
			self.view = view
		}
	}

	func detachView(view: AvailableFundsView) {
		if (self.view === view) {
			self.view = nil
		}
	}
}