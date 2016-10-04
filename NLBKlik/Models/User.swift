//
//  User.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class User {
	private var username: String
	private var password: String
	private var autoLogin: Bool

	init(username: String, password: String, autoLogin: Bool) {
		self.username = username
		self.password = password
		self.autoLogin = autoLogin
	}
}