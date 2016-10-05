//
//  AvailableFundsController.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/5/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import UIKit

class AvailableFundsController: BaseViewController, AvailableFundsView {
	private var presenter: AvailableFundsPresenter
	private var items: [[String: String]]?
	private let cellID = "AvailableFundsCell"
	private var tableView: UITableView!

	init(presenter: AvailableFundsPresenter) {
		self.presenter = presenter
		super.init()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		presenter.detachView(self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.attachView(self)
	}

	override func setupViews() {
		super.setupViews()

		view.backgroundColor = UIColor.whiteColor()

		tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellID)
		tableView.sectionHeaderHeight = 40

		view.addSubview(tableView)
	}

	override func setupConstraints() {
		super.setupConstraints()

		tableView.snp_makeConstraints { (make) in
			make.edges.equalTo(self.view)
		}
	}

	func showItems(items: [[String: String]]) {
		self.items = items
		tableView.reloadData()
	}
}

extension AvailableFundsController: UITableViewDelegate {
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 50
	}
}

extension AvailableFundsController: UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items?.count ?? 0
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(cellID)!
		cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
		let currentItem = items![indexPath.row]
		cell.textLabel?.text = currentItem[ItemKeys.text]
		cell.imageView?.image = UIImage(named: currentItem[ItemKeys.image] ?? "")
		return cell
	}
}

