//
//  ReservedFundsPresenter.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

protocol ReservedFundsPresenter {
	func attachView(view: ReservedFundsView)
	func detachView(view: ReservedFundsView)
}