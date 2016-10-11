//
//  AvailableFundsView.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/5/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

@objc protocol AvailableFundsView {
	func animate(shouldAnimate: Bool)
	func showItems(transactionAcc: [[String: String]], debitCards: [[String: String]])
	func showLoginScreen()
    func showConnectionError()
    func resetButtons()
}