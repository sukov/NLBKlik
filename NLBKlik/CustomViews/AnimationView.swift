//
//  AnimationView.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

class AnimationView: UIView {
	private var overlayView: UIView!
	private var activityView: UIActivityIndicatorView!

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupViews() {
		hidden = true
		backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)

		activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
		activityView.center = self.center
		activityView.color = UIColor.customPurple()

		addSubview(activityView)
	}

	func animate(shouldAnimate: Bool) {
		if (shouldAnimate) {
			self.hidden = false
			activityView.startAnimating()
		} else {
			activityView.stopAnimating()
			self.hidden = true
		}
	}
}
