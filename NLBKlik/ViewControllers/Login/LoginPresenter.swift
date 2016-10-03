//
//  LoginPresenter.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

protocol LoginPresenter {
	func attachView(view: LoginView)
	func detachView(view: LoginView)
}