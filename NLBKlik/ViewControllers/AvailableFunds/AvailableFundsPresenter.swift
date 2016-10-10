//
//  AvailableFundsPresenter.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/5/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

protocol AvailableFundsPresenter {
	func attachView(view: AvailableFundsView)
	func detachView(view: AvailableFundsView)
	func refresh()
}