//
//  LoginController.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/3/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import UIKit
import SnapKit

class LoginController: BaseViewController, LoginView {
	private var presenter: LoginPresenter
	private var logoImageView: UIImageView!
	private var usernameTextField: UITextField!
	private var passwordTextField: UITextField!
	private var loginButton: UIButton!
	private var rememberMeSwitch: UISwitch!
	private var autoLoginSwitch: UISwitch!

	init(presenter: LoginPresenter) {
		self.presenter = presenter
		super.init()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func setupViews() {

	}

	override func setupConstraints() {

	}

	func fillTextFields() {

	}

	func animate(shouldAnimate: Bool) {

	}

	func showNextScreen() {

	}
}
