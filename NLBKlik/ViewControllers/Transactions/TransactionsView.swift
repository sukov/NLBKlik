//
//  TransactionsView.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

@objc protocol TransactionsView {
	func showItems(items: [[String: String]])
    func showNextPageButton(shouldShow: Bool)
}