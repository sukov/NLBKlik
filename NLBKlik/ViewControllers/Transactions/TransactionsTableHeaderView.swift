//
//  TransactionsTableHeaderView.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/7/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

class TransactionsTableHeaderView: UIView {
	private var date: UILabel
	private var desc: UILabel
	private var amount: UILabel

	init() {
		date = UILabel()
		desc = UILabel()
		amount = UILabel()

		let width = UIScreen.mainScreen().bounds.width - 10
		super.init(frame: CGRectMake(0, 0, width, 30))

		setupViews()
		setupConstraints()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupViews() {
		backgroundColor = UIColor.grayColor()

		date.text = "Date"
		date.textColor = UIColor.whiteColor()
		date.textAlignment = .Center

		desc.text = "Description"
		desc.textColor = UIColor.whiteColor()
		desc.textAlignment = .Center

		amount.text = "Amount"
		amount.textColor = UIColor.whiteColor()
		amount.textAlignment = .Center

		addSubview(date)
		addSubview(desc)
		addSubview(amount)
	}

	func setupConstraints() {
		let width = (UIScreen.mainScreen().bounds.width - 10) / 3

		date.snp_makeConstraints { (make) in
			make.top.bottom.equalTo(self)
			make.left.equalTo(self)
			make.width.equalTo(90)
		}

		amount.snp_makeConstraints { (make) in
			make.top.bottom.equalTo(self)
			make.right.equalTo(self)
			make.width.equalTo(width)
		}

		desc.snp_makeConstraints { (make) in
			make.top.bottom.equalTo(self)
			make.left.equalTo(date.snp_right)
			make.right.equalTo(amount.snp_left)
		}
	}

}
