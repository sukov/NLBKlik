//
//  MenuController.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/5/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import UIKit

class MenuController: BaseViewController, MenuView {
	private var presenter: MenuPresenter
	private var items: [[String: String]]?
	private let cellID = "MenuCell"
	private var tableView: UITableView!
    var viewControllers: [UIViewController]

	init(presenter: MenuPresenter) {
		self.presenter = presenter
        viewControllers = []
        
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

		tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellID)
		tableView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.1)
        tableView.alwaysBounceVertical = false

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
		tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
	}
}

extension MenuController: UITableViewDelegate {
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        revealViewController().pushFrontViewController(viewControllers[indexPath.row], animated: true)
    }
}

extension MenuController: UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items?.count ?? 0
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(cellID)!
		cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
		let currentItem = items![indexPath.row]
		cell.textLabel?.text = currentItem[MenuItemKeys.text]
		cell.imageView?.image = UIImage(named: currentItem[MenuItemKeys.image] ?? "")
		return cell
	}
}