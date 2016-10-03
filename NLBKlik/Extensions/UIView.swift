//
//  UIView.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func addBorder(edges edges: UIRectEdge, colour: UIColor = UIColor.whiteColor(), thickness: CGFloat = 1) {

		func border() -> UIView {
			let border = UIView(frame: CGRectZero)
			border.backgroundColor = colour
			border.translatesAutoresizingMaskIntoConstraints = false
			return border
		}

		if edges.contains(.Top) || edges.contains(.All) {
			let top = border()
			addSubview(top)
			addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[top(==thickness)]",
					options: [],
					metrics: ["thickness": thickness],
					views: ["top": top]))
			addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[top]-(0)-|",
					options: [],
					metrics: nil,
					views: ["top": top]))
		}

		if edges.contains(.Left) || edges.contains(.All) {
			let left = border()
			addSubview(left)
			addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[left(==thickness)]",
					options: [],
					metrics: ["thickness": thickness],
					views: ["left": left]))
			addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[left]-(0)-|",
					options: [],
					metrics: nil,
					views: ["left": left]))
		}

		if edges.contains(.Right) || edges.contains(.All) {
			let right = border()
			addSubview(right)
			addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormat("H:[right(==thickness)]-(0)-|",
					options: [],
					metrics: ["thickness": thickness],
					views: ["right": right]))
			addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[right]-(0)-|",
					options: [],
					metrics: nil,
					views: ["right": right]))
		}

		if edges.contains(.Bottom) || edges.contains(.All) {
			let bottom = border()
			addSubview(bottom)
			addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormat("V:[bottom(==thickness)]-(0)-|",
					options: [],
					metrics: ["thickness": thickness],
					views: ["bottom": bottom]))
			addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[bottom]-(0)-|",
					options: [],
					metrics: nil,
					views: ["bottom": bottom]))
		}

	}
}