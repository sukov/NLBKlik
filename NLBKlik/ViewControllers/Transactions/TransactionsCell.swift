//
//  TransactionsCell.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/7/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

class TransactionsCell: UITableViewCell {
	private var date: UILabel!
	private var desc: UILabel!
	private var amount: UILabel!
	static let fontSize: CGFloat = 14

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupViews()
		setupConstraints()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		amount.textColor = UIColor.blackColor()
	}

	func setupViews() {
		date = UILabel()
		date.font = date.font.fontWithSize(TransactionsCell.fontSize)

		desc = UILabel()
		desc.lineBreakMode = .ByWordWrapping
		desc.numberOfLines = 0
		desc.font = desc.font.fontWithSize(TransactionsCell.fontSize)

		amount = UILabel()
		amount.textAlignment = .Right
		amount.lineBreakMode = .ByWordWrapping
		amount.numberOfLines = 0
		amount.font = amount.font.fontWithSize(TransactionsCell.fontSize)

		addSubview(date)
		addSubview(desc)
		addSubview(amount)
	}

	func setupConstraints() {
		let width = (UIScreen.mainScreen().bounds.width - 10) / 3

		date.snp_makeConstraints { (make) in
			make.top.bottom.equalTo(self)
			make.left.equalTo(self).inset(5)
			make.width.equalTo(90)
		}

		amount.snp_makeConstraints { (make) in
			make.top.bottom.equalTo(self)
			make.right.equalTo(self).inset(5)
			make.width.equalTo(width)
		}

		desc.snp_makeConstraints { (make) in
			make.top.bottom.equalTo(self)
			make.left.equalTo(date.snp_right)
			make.right.equalTo(amount.snp_left)
		}

	}

	func setContent(item: [String: String]?) {
		date.text = item?[TransactionKeys.date]
		desc.text = item?[TransactionKeys.desc]
		amount.text = item?[TransactionKeys.amount]

		if (item?[TransactionKeys.amount]?.containsString("-") == true) {
			amount.textColor = UIColor.redColor()
		}
	}

	static func calculateFontHeight(text: String?, fontSize: CGFloat = AvailableFundsCell.fontSize) -> CGFloat {
		guard text != nil else {
			return 20
		}

		let width: CGFloat = UIScreen.mainScreen().bounds.width - (((UIScreen.mainScreen().bounds.width - 10) / 3) + 90)
		let maxLineCharacters = (width / fontSize) * 1.95
		let fontHeight = fontSize + 7
		return ceil(CGFloat(text!.characters.count) / maxLineCharacters) * fontHeight
	}
}

