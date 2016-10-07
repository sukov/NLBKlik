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
	private var transactionAcc: [[String: String]]?
	private var debitCards: [[String: String]]?
	private var tableView: UITableView!
	private let cellID = "AvailableFundsCell"
	private let accountsHeaderView = AvailableFundsTableHeaderView(headerName: "Accounts")
	private let debitCardsHeaderView = AvailableFundsTableHeaderView(headerName: "Debit Cards")

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

		view.backgroundColor = UIColor.customGray()

		tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
		tableView.alwaysBounceVertical = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(AvailableFundsCell.self, forCellReuseIdentifier: cellID)
		tableView.backgroundColor = UIColor.customGray()
		tableView.allowsSelection = false

		view.addSubview(tableView)
	}

	override func setupConstraints() {
		super.setupConstraints()

		tableView.snp_makeConstraints { (make) in
			make.top.equalTo(navigationController?.navigationBar.frame.height ?? 0).offset(20)
			make.left.equalTo(self.view).offset(10)
			make.right.equalTo(self.view).offset(-10)
			make.bottom.equalTo(self.view)
		}
	}
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
       
        navigationItem.title = "Available funds"
    }

	func showItems(transactionAcc: [[String: String]], debitCards: [[String: String]]) {
		self.transactionAcc = transactionAcc
		self.debitCards = debitCards
		tableView.reloadData()
	}
}

extension AvailableFundsController: UITableViewDelegate {
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return (section == 0) ? accountsHeaderView : debitCardsHeaderView
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		let currentItem = (indexPath.section == 0) ? transactionAcc?[indexPath.row]: debitCards?[indexPath.row]
		return AvailableFundsCell.calculateFontHeight(currentItem?[AccountKeys.name]) + 5
	}

	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
}

extension AvailableFundsController: UITableViewDataSource {

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 2
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ((section == 0) ? transactionAcc?.count : debitCards?.count) ?? 0
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! AvailableFundsCell

		let currentItem = (indexPath.section == 0) ? transactionAcc?[indexPath.row]: debitCards?[indexPath.row]
		cell.setContent(currentItem)
		return cell
	}
}

