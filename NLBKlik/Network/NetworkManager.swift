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
		case FirstPage
		case LogIn
		case Transactions
		case ReservedFunds
	}

	static let sharedInstance = NetworkManager()
	private var webView: UIWebView = UIWebView()
	private var pageCoordinator: Int = 0
	private var nextPage: Page = .FirstPage
	private var pageLoadCompleted: Optional < () -> Void >
	private var logInCompleted: Optional < () -> Void >
	private var transactionsLoadCompleted: Optional < () -> Void >
	private var reservedFundsLoadCompleted: Optional < () -> Void >

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
		case 2: if (nextPage == .LogIn) {
			logInCompleted?()
			}
		case 7, 12: if (nextPage == .Transactions) {
			transactionsLoadCompleted?()
			} else if (nextPage == .ReservedFunds) {
			reservedFundsLoadCompleted?()
			}
		case 12: pageCoordinator -= 5
		default: nextPage = .Uknown
		}

		print(pageCoordinator)
	}

	func loadWebPage(complete: ((sucess: Bool) -> Void)?) {
		if (pageCoordinator > 0) {
			complete?(sucess: true)
		} else {
			pageLoadCompleted = {
				complete?(sucess: true)
			}
		}
	}

	func reloadWebPage(complete: (sucess: Bool) -> Void) {
		pageCoordinator = 0
		webView.reload()

		pageLoadCompleted = {
			complete(sucess: true)
		}
	}

	func login(username: String, password: String, complete: (sucess: Bool) -> Void) {
		nextPage = .LogIn
		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_UserNameTextBox').value = '\(username)'")
		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_PasswordTextBox').value = '\(password)'")

		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_*').click()")

		logInCompleted = {
			complete(sucess: true)
		}
		// NSTimer.scheduledTimerWithTimeInterval(7.5, target: self, selector: #selector(getTotal), userInfo: nil, repeats: false)

		// NSTimer.scheduledTimerWithTimeInterval(8.5, target: self, selector: #selector(getRezervniSredstva), userInfo: nil, repeats: false)
	}

	func getTotal(complete: (sucess: Bool) -> Void) {
//		pageLoaded = {
//			self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_1_a_href').click()")
//			print(self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('strong')[0].innerHTML"))
//			complete(sucess: true)
//		}
		// print(total.text)
	}

	func getTransactions() {
		nextPage = .Transactions

		self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_21_a_href').click()")
		self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_25_Item').click()")
		// NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector(getTableData), userInfo: nil, repeats: false)
		transactionsLoadCompleted = {

		}
	}

	func getReservedFunds() {
		nextPage = .ReservedFunds

		self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_21_a_href').click()")
		self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_29_Item').click()")
		reservedFundsLoadCompleted = {

		}
	}

	func getTableData() {

		print(webView.stringByEvaluatingJavaScriptFromString(
			"document.getElementById('ctl00_DefaultContent_ctl01_gvCustoms').getElementsByTagName('tr')[0].getElementsByTagName('th')[1].innerHTML"))
	}

}