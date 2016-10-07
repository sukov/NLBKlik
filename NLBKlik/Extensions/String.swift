//
//  String.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/7/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

extension String {
	public func customTrim() -> String {
		var currentString = stringByReplacingOccurrencesOfString("&nbsp;", withString: "")
		currentString.removeHTMLTags()
		currentString.condenseWhitespace()
		return currentString
	}

	private mutating func removeHTMLTags() {
		while (containsString("<")) {
			if let selectorOpenIndex = characters.indexOf("<"), selectorClosedIndex = characters.indexOf(">") {
				self = stringByReplacingCharactersInRange(selectorOpenIndex...selectorClosedIndex, withString: "")
			} else {
				break
			}
		}
	}

	public mutating func condenseWhitespace() {
		let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		self = components.filter { !$0.isEmpty }.joinWithSeparator(" ")
	}
}