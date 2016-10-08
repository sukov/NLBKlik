//
//  TransactionsPresenter.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

protocol TransactionsPresenter {
	func attachView(view: TransactionsView)
	func detachView(view: TransactionsView)
	func loadNextPage()
}