//
//  MenuPresenterImp.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/5/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class MenuPresenterImp: MenuPresenter {
	weak private var view: MenuView?

	func attachView(view: MenuView) {
		if (self.view == nil) {
			self.view = view
			let items = [[MenuItemKeys.text: "Available funds", MenuItemKeys.image: "AvailableFunds"],
				[MenuItemKeys.text: "Transactions", MenuItemKeys.image: "Transactions"],
				[MenuItemKeys.text: "Reserved funds", MenuItemKeys.image: "ReservedFunds"]]
			view.showItems(items)
		}
	}

	func detachView(view: MenuView) {
		if (self.view === view) {
			self.view = nil
		}
	}
}