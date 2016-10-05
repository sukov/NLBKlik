//
//  NetworkManager.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/4/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject, UIWebViewDelegate {
	enum Page {
		case Uknown
		case LogIn
		case AvailableFunds
		case Transactions
		case ReservedFunds
	}

	static let sharedInstance = NetworkManager()
	private var webView: UIWebView = UIWebView()
	private var pageCoordinator: Int = 0
	private var currentPage: Page = .LogIn
	private var nextPage: Page = .Uknown
	private var pageLoadCompleted: Optional < () -> Void >
	private var logInCompleted: Optional < (success: Bool) -> Void >
	private var loadingFinnished: Optional < () -> Void >

	override init() {
		super.init()
		webView.delegate = self
	}

	func tempTest() -> UIWebView {
		return webView
	}

	func webViewDidFinishLoad(webView: UIWebView) {
		pageCoordinator += 1
		switch pageCoordinator {
		case 1: pageLoadCompleted?()
		case 2: if (nextPage == .AvailableFunds) {
			logInCompleted?(success: true)
			}
		default: break
		}

		print(pageCoordinator)
	}

	func loadWebPage(complete: ((success: Bool) -> Void)?) {
		if (pageCoordinator > 0) {
			complete?(success: true)
		} else {
			self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.nlbklik.com.mk/LoginModule/LoginUP.aspx")!))
			pageLoadCompleted = {
				complete?(success: true)
			}
		}
	}

	func reloadWebPage(complete: (success: Bool) -> Void) {
		pageCoordinator = 0
		webView.reload()

		pageLoadCompleted = {
			complete(success: true)
		}
	}

	func login(username: String, password: String, complete: (success: Bool) -> Void) {
		nextPage = .AvailableFunds
		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_UserNameTextBox').value = '\(username)'")
		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_PasswordTextBox').value = '\(password)'")

		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_*').click()")
		let timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(checkForLoginErrors), userInfo: nil, repeats: true)
		logInCompleted = { success in
			timer.invalidate()
			if (success) {
				self.currentPage = .AvailableFunds
			}
			complete(success: success)
		}
	}

	func getAvailableFunds(complete: (transactionAcc: [[String: String]]?, debitCards: [[String: String]]?, success: Bool) -> Void) {
		if (currentPage != .AvailableFunds) {
			nextPage = .AvailableFunds
			self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_1_a_href').click()")
			self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_3_Item').click()")
		}
		let timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(checkIfLoadingIsFinnished), userInfo: nil, repeats: true)
		loadingFinnished = {
			timer.invalidate()
			self.currentPage = .AvailableFunds
			let accountsCount = Int(self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr').length"))!

			var transactionAcc = [[String: String]]()
			var debitCards = [[String: String]]()

			var transaction: Bool = true
			for i in 1..<accountsCount {
				if (self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].className") == "group") {
					transaction = false
				}

				if (transaction) {
					let accountName = self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[1].getElementsByTagName('span')[0].innerHTML").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) + "\n" + self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[1].getElementsByTagName('i')[0].innerHTML")

					guard accountName.characters.count > 4 else {
						continue
					}

					let availableFunds = self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('strong')[0].innerHTML").characters.split { $0 == "&" }.map(String.init)[0]

					transactionAcc.append([AccountKeys.name: accountName, AccountKeys.availableFunds: availableFunds])
				}
				else {
					let cardName = self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[1].getElementsByTagName('span')[0].innerHTML").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) + "\n" + self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[1].getElementsByTagName('i')[0].innerHTML")

					guard cardName.characters.count > 4 else {
						continue
					}

					let availableFunds = self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('strong')[1].innerHTML")
					debitCards.append([AccountKeys.name: cardName, AccountKeys.availableFunds: availableFunds])
				}
				print(transactionAcc)
				print(debitCards)
			}
			complete(transactionAcc: transactionAcc, debitCards: debitCards, success: true)
		}
		// print(self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('strong')[0].innerHTML"))
	}

	func getTransactions() {
		nextPage = .Transactions

		self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_21_a_href').click()")
		self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_25_Item').click()")

		loadingFinnished = {
			self.currentPage = .Transactions
		}
	}

	func getReservedFunds() {
		nextPage = .ReservedFunds

		self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_21_a_href').click()")
		self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_29_Item').click()")

		loadingFinnished = {
			self.currentPage = .Transactions
		}
	}

	func getTableData() {

		print(webView.stringByEvaluatingJavaScriptFromString(
			"document.getElementById('ctl00_DefaultContent_ctl01_gvCustoms').getElementsByTagName('tr')[0].getElementsByTagName('th')[1].innerHTML"))
	}

	@objc private func checkIfLoadingIsFinnished() {
		if (self.webView.stringByEvaluatingJavaScriptFromString(("document.getElementById('ctl00_DefaultContent_ctl00_infoDialog_mainPanel').style.display")) == "none") {
			loadingFinnished?()
		}
	}

	@objc private func checkForLoginErrors() {
		if (executeJavaScriptFromString("document.getElementById('ctl00_DefaultContent_ltrMessage').innerHTML") != "") {
			logInCompleted?(success: false)
		}
	}

	private func executeJavaScriptFromString(string: String) -> String {
		return webView.stringByEvaluatingJavaScriptFromString(string) ?? ""
	}

}