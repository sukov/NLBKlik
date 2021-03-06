//
//  TransactionsController.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

class TransactionsController: BaseViewController, TransactionsView, TransactionButtonCellProtocol {
	private var presenter: TransactionsPresenter
	private var items: [[String: String]]?
	private var tableView: UITableView!
	private let cellID1 = "TransactionsCell"
	private let cellID2 = "TransactionsButtonCell"
	private var showNextPageButton: Bool = false
	private var hideCellButton: Bool = false
	private var animationView: AnimationView!

	init(presenter: TransactionsPresenter) {
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

		tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(TransactionsCell.self, forCellReuseIdentifier: cellID1)
		tableView.registerClass(TransactionsButtonCell.self, forCellReuseIdentifier: cellID2)
		tableView.sectionHeaderHeight = 30
		tableView.sectionFooterHeight = 1
		tableView.allowsSelection = false
		tableView.backgroundColor = UIColor.customGray()

		animationView = AnimationView(frame: UIScreen.mainScreen().bounds)

		view.addSubview(tableView)
		view.addSubview(animationView)
	}

	override func setupConstraints() {
		super.setupConstraints()

		tableView.snp_makeConstraints { (make) in
			make.top.equalTo(navigationController?.navigationBar.frame.height ?? 0).offset(5)
			make.left.equalTo(self.view).offset(5)
			make.right.equalTo(self.view).offset(-5)
			make.bottom.equalTo(self.view)
		}
	}

	override func refresh() {
		super.refresh()
		navigationItem.rightBarButtonItem?.enabled = false
		if (NetworkManager.sharedInstance.isConnectedToNetwork()) {
			items = nil
		}
		presenter.refresh()
	}

	func animate(shouldAnimate: Bool) {
		animationView.animate(shouldAnimate)
	}

	func showItems(items: [[String: String]]) {
		if (self.items == nil) {
			self.items = items
		} else {
			self.items?.appendContentsOf(items)
		}

		hideCellButton = false
		tableView.reloadData()
		navigationItem.rightBarButtonItem?.enabled = true
	}

	func showNextPageButton(shouldShow: Bool) {
		showNextPageButton = shouldShow
	}

	func nextPageButtonTapped() {
		hideCellButton = true
		presenter.loadNextPage()
	}

	func resetButtons() {
		navigationItem.rightBarButtonItem?.enabled = true
		hideCellButton = false
		tableView.reloadData()
	}

	func showLoginScreen() {
		presentViewController(MainAssembly.sharedInstance.getLoginController(), animated: true, completion: nil)
	}

	func showConnectionError() {
		let iOSVerzion = NSProcessInfo().operatingSystemVersion.majorVersion

		if (iOSVerzion <= 9) {
			presentViewController(AlertFactory.connectionError(), animated: true, completion: nil)
		} else {
			AlertFactory.connectionErrorIOS10()
		}
	}

	func navigationBarTitle(name: String) {
		navigationItem.title = name
	}
}

extension TransactionsController: UITableViewDelegate {
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return TransactionsTableHeaderView()
	}

	func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView()
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		let minimumHeight: CGFloat = 47

		if (indexPath.row < items?.count) {
			let amountHeight = TransactionsCell.calculateFontHeight((items?[indexPath.row])?[TransactionKeys.amount])
			let descHeight = TransactionsCell.calculateFontHeight((items?[indexPath.row])?[TransactionKeys.desc])
			let greaterHeight = max(amountHeight + 5, descHeight + 5)
			return max(greaterHeight, minimumHeight)
		} else {
			return minimumHeight
		}
	}
}

extension TransactionsController: UITableViewDataSource {

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ((items?.count ?? 0) + ((showNextPageButton == true) ? 1 : 0))
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if (indexPath.row < items?.count) {
			let cell = tableView.dequeueReusableCellWithIdentifier(cellID1) as! TransactionsCell
			cell.setContent(items?[indexPath.row])
			return cell
		} else {
			let cell = tableView.dequeueReusableCellWithIdentifier(cellID2) as! TransactionsButtonCell
			cell.delegate = self
			if (hideCellButton) {
				cell.set()
			}
			return cell
		}
	}
}
