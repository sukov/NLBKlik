//
//  AvailableFundsCell.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

class AvailableFundsCell: UITableViewCell {
	private var accountName: UILabel!
	private var availableFunds: UILabel!
	static let fontSize: CGFloat = 14

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupViews()
		setupConstraints()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupViews() {
		accountName = UILabel()
		accountName.font = accountName.font.fontWithSize(AvailableFundsCell.fontSize)
		accountName.lineBreakMode = NSLineBreakMode.ByWordWrapping
		accountName.numberOfLines = 0
        accountName.enableCopyMenu()

		availableFunds = UILabel()
		availableFunds.font = availableFunds.font.fontWithSize(AvailableFundsCell.fontSize)
		availableFunds.textAlignment = .Right
		availableFunds.lineBreakMode = .ByWordWrapping
		availableFunds.numberOfLines = 0

		addSubview(accountName)
		addSubview(availableFunds)
	}

	func setupConstraints() {
		accountName.snp_makeConstraints { (make) in
			make.top.equalTo(self)
			make.left.equalTo(self).inset(5)
			make.bottom.equalTo(self)
			make.width.equalTo(self).dividedBy(2)
		}

		availableFunds.snp_makeConstraints { (make) in
			make.top.equalTo(self)
			make.right.equalTo(self).inset(5)
			make.bottom.equalTo(self)
			make.width.equalTo(self).dividedBy(2)
		}
	}

	func setContent(item: [String: String]?) {
		accountName.text = item?[AccountKeys.name]
		availableFunds.text = item?[AccountKeys.availableFunds]
	}

	static func calculateFontHeight(text: String?, width: CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 2, fontSize: CGFloat = AvailableFundsCell.fontSize) -> CGFloat {
		guard text != nil else {
			return 30
		}

		let maxLineCharacters = (width / fontSize) * 1.95
		let fontHeight = fontSize + 7
		return ceil(CGFloat(text!.characters.count) / maxLineCharacters) * fontHeight
	}
}
