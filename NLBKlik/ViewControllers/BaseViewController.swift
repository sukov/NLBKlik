//
//  BaseViewController.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
	let refreshBtn = UIButton()

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupConstraints()
		setupNavigationBar()
	}

	func setupViews() {

	}

	func setupConstraints() {

	}

	func setupNavigationBar() {
		navigationController?.navigationBar.barTintColor = UIColor.navBarGray()

		let revealBtn = UIButton()
		revealBtn.setImage(UIImage(named: "RevealIcon"), forState: .Normal)
		revealBtn.frame = CGRectMake(0, 0, 30, 30)
		let revealBarButton = UIBarButtonItem()
		revealBarButton.customView = revealBtn
		navigationItem.leftBarButtonItem = revealBarButton
		let revealController = revealViewController()
		revealBtn.addTarget(revealController, action: #selector(revealController.revealToggle(_:)), forControlEvents: .TouchUpInside)
		navigationController?.navigationBar.translucent = false

		refreshBtn.setImage(UIImage(named: "RefreshIcon"), forState: .Normal)
		refreshBtn.frame = CGRectMake(0, 0, 30, 30)
		let refreshBarButton = UIBarButtonItem()
		refreshBarButton.customView = refreshBtn
		navigationItem.rightBarButtonItem = refreshBarButton
		refreshBtn.addTarget(self, action: #selector(refresh), forControlEvents: .TouchUpInside)
	}

	func refresh() {

	}
}
