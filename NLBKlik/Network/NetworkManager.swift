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
		case FirstPageAfterLogin
		case AvailableFunds
		case Transactions
		case ReservedFunds
	}

	static let sharedInstance = NetworkManager()
	private var webView: UIWebView = UIWebView()
	private var currentPage: Page = .Uknown
	private var nextPage: Page = .LogIn
	private var pageLoadCompleted: Optional < () -> Void >
	private var logInCompleted: Optional < (success: Bool) -> Void >
	private var loadingFinnished: Optional < () -> Void >
	private var timer: NSTimer?

	override init() {
		super.init()
		webView.delegate = self
	}

	func tempTest() -> UIWebView {
		return webView
	}

	func webViewDidFinishLoad(webView: UIWebView) {
		if currentPage == .Uknown {
			currentPage = .LogIn
			pageLoadCompleted?()
		} else if (nextPage == .FirstPageAfterLogin) {
			logInCompleted?(success: true)
		}
	}

	func loadWebPage(complete: ((success: Bool) -> Void)?) {
		if (currentPage != .Uknown) {
			complete?(success: true)
		} else {
			self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.nlbklik.com.mk/LoginModule/LoginUP.aspx")!))
            
			pageLoadCompleted = {
				complete?(success: true)
			}
		}
	}

	func reloadWebPage(complete: (success: Bool) -> Void) {
		currentPage = .Uknown
		nextPage = .LogIn

		webView.reload()

		pageLoadCompleted = {
			complete(success: true)
		}
	}

	func login(username: String, password: String, complete: (success: Bool) -> Void) {
		nextPage = .FirstPageAfterLogin
		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_UserNameTextBox').value = '\(username)'")
		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_PasswordTextBox').value = '\(password)'")

		webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_DefaultContent_UsernamePasswordLogin1_*').click()")
		timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(checkForLoginErrors), userInfo: nil, repeats: true)
		logInCompleted = { success in
			self.timer?.invalidate()
			if (success) {
				self.currentPage = .FirstPageAfterLogin
			}
			complete(success: success)
		}
	}

	func getAvailableFunds(complete: (transactionAcc: [[String: String]]?, debitCards: [[String: String]]?, success: Bool) -> Void) {
		timer?.invalidate()
		loadingFinnished?()
		nextPage = .AvailableFunds
        
		loadingFinnished = {
			self.timer?.invalidate()
			self.currentPage = .AvailableFunds
			if let accountsCount = Int(self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr').length")) {

				var transactionAcc = [[String: String]]()
				var debitCards = [[String: String]]()

				var transaction: Bool = true
				for i in 1..<accountsCount {
					if (self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].className") == "group") {
						transaction = false
					}

					if (transaction) {
						let accountName = self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[1].innerHTML").customTrim()

						guard accountName.characters.count > 4 else {
							continue
						}

						let availableFunds = self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByClassName('amount')[0].getElementsByTagName('strong')[0].innerHTML").customTrim()

						print(self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByClassName('amount')[0].getElementsByTagName('strong')[0].innerHTML"))

						transactionAcc.append([AccountKeys.name: accountName, AccountKeys.availableFunds: availableFunds])
					}
					else {
						let cardName = self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[1].getElementsByTagName('span')[0].innerHTML").customTrim() + " " + self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[1].getElementsByTagName('i')[0].innerHTML")

						guard cardName.characters.count > 4 else {
							continue
						}

						let availableFunds = self.executeJavaScriptFromString("(document.getElementById('orders')).getElementsByTagName('tr')[\(i)].getElementsByClassName('amount')[1].getElementsByTagName('strong')[0].innerHTML")
						debitCards.append([AccountKeys.name: cardName, AccountKeys.availableFunds: availableFunds])
					}
				}
				complete(transactionAcc: transactionAcc, debitCards: debitCards, success: true)
			} else {
				complete(transactionAcc: nil, debitCards: nil, success: false)
			}
		}
        
        if (currentPage != nextPage) {
            self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_1_a_href').click()")
            self.webView.stringByEvaluatingJavaScriptFromString("document.getElementById('key_3_Item').click()")
            timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(checkIfLoadingIsFinnished), userInfo: nil, repeats: true)
        } else {
            loadingFinnished?()
        }
	}

    func getTransactions(loadNextTransactionsPage: Bool = false ,complete: (items: [[String: String]]?, pageCount: Int?, success: Bool) -> Void) {
		timer?.invalidate()
        (currentPage != nextPage) ? loadingFinnished?() : ()
		nextPage = .Transactions

			loadingFinnished = {
			self.timer?.invalidate()
			self.currentPage = .Transactions
			self.executeJavaScriptFromString("document.getElementById('ctl00_DefaultContent_ctl01_gvCustoms')")

			if let transactionsCount = Int(self.executeJavaScriptFromString("document.getElementById('ctl00_DefaultContent_ctl01_gvCustoms').getElementsByTagName('tr').length")), pageCount = Int(self.executeJavaScriptFromString("document.getElementsByClassName('pager_links')[0].innerHTML").customTrim().characters.split { $0 == " " }.map(String.init)[3]) {

				var items = [[String: String]]()
				for i in 1...transactionsCount {
					let date = self.executeJavaScriptFromString("document.getElementById('ctl00_DefaultContent_ctl01_gvCustoms').getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[1].innerHTML").customTrim()

					let desc = self.executeJavaScriptFromString("document.getElementById('ctl00_DefaultContent_ctl01_gvCustoms').getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[3].innerHTML").customTrim()

					let amount = self.executeJavaScriptFromString("document.getElementById('ctl00_DefaultContent_ctl01_gvCustoms').getElementsByTagName('tr')[\(i)].getElementsByTagName('td')[4].getElementsByTagName('span')[0].innerHTML").customTrim()

                    if ( desc != "" ) {
                        items.append([TransactionKeys.date: date, TransactionKeys.desc: desc, TransactionKeys.amount: amount])
                    }
				}
				complete(items: items, pageCount: pageCount, success: true)
			} else {
				complete(items: nil, pageCount: nil, success: false)
			}
		}
        
        if (currentPage != nextPage) {
            executeJavaScriptFromString("document.getElementById('key_21_a_href').click()")
            executeJavaScriptFromString("document.getElementById('key_25_Item').click()")
            timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(checkIfLoadingIsFinnished), userInfo: nil, repeats: true)
        } else if(loadNextTransactionsPage == true) {
            executeJavaScriptFromString("document.getElementById('ctl00_DefaultContent_ctl01_pager_lbNextPage').click()")
            timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(checkIfLoadingIsFinnished), userInfo: nil, repeats: true)
        } else {
            loadingFinnished?()
        }
	}

	func getReservedFunds() {
		nextPage = .ReservedFunds

		executeJavaScriptFromString("document.getElementById('key_21_a_href').click()")
		executeJavaScriptFromString("document.getElementById('key_29_Item').click()")

		loadingFinnished = {
			self.currentPage = .Transactions
		}
	}

	@objc private func checkIfLoadingIsFinnished() {
		if (self.webView.stringByEvaluatingJavaScriptFromString(("document.getElementsByClassName('WaitDialogCls')[0].style.display")) == "none") {
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