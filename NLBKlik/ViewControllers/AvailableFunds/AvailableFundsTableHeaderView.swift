//
//  AvailableFundsTableHeaderView.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

class AvailableFundsTableHeaderView: UIView {
	var headerNameLabel: UILabel
	private var availableFundsLabel: UILabel
	private var accountNameLabel: UILabel

	init(headerName: String) {
		headerNameLabel = UILabel()
		availableFundsLabel = UILabel()
		accountNameLabel = UILabel()

		let width = UIScreen.mainScreen().bounds.width - 20
		super.init(frame: CGRectMake(0, 0, width, 40))

		headerNameLabel.text = headerName
		setupViews()
		setupConstraints()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupViews() {
		backgroundColor = UIColor.grayColor()

		headerNameLabel.textAlignment = .Center
		headerNameLabel.font = UIFont.boldSystemFontOfSize(17)
		headerNameLabel.textColor = UIColor.whiteColor()
		availableFundsLabel.text = "Available funds"
		availableFundsLabel.textColor = UIColor.whiteColor()
		accountNameLabel.text = "Name"
		accountNameLabel.textColor = UIColor.whiteColor()

		addSubview(headerNameLabel)
		addSubview(availableFundsLabel)
		addSubview(accountNameLabel)
	}

	func setupConstraints() {
		headerNameLabel.snp_makeConstraints { (make) in
			make.left.right.top.equalTo(self)
		}
		accountNameLabel.snp_makeConstraints { (make) in
			make.top.equalTo(headerNameLabel.snp_bottom)
			make.left.equalTo(self).inset(5)
		}
		availableFundsLabel.snp_makeConstraints { (make) in
			make.top.equalTo(headerNameLabel.snp_bottom)
			make.right.equalTo(self).inset(5)
		}
	}
}
