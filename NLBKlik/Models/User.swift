//
//  User.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
	var username: String
	var password: String
	var autoLogin: Bool

	init(username: String, password: String, autoLogin: Bool) {
		self.username = username
		self.password = password
		self.autoLogin = autoLogin
	}

	convenience init?(userData: [String: AnyObject]) {
		if let username = userData[UserDataKeys.username] as? String,
			password = userData[UserDataKeys.password] as? String,
			autoLogin = userData[UserDataKeys.autoLogin] as? Bool {
				self.init(username: username, password: password, autoLogin: autoLogin)
		} else {
				return nil
		}
	}

	required convenience init?(coder aDecoder: NSCoder) {
		if let username = aDecoder.decodeObjectForKey(UserDataKeys.username) as? String, password = aDecoder.decodeObjectForKey(UserDataKeys.password) as? String {
			let autoLogin = aDecoder.decodeBoolForKey(UserDataKeys.autoLogin)
			self.init(username: username, password: password, autoLogin: autoLogin)
		} else {
			return nil
		}
	}

	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(username, forKey: UserDataKeys.username)
		aCoder.encodeObject(password, forKey: UserDataKeys.password)
		aCoder.encodeBool(autoLogin, forKey: UserDataKeys.autoLogin)
	}
}