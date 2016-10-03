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
	private var rememberMeLabel: UILabel!
	private var rememberMeSwitch: UISwitch!
	private var autoLoginLabel: UILabel!
	private var autoLoginSwitch: UISwitch!

	init(presenter: LoginPresenter) {
		self.presenter = presenter
		super.init()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		presenter.attachView(self)
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		presenter.detachView(self)
	}

	override func setupViews() {
		view.backgroundColor = UIColor.whiteColor()
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

		logoImageView = UIImageView(image: UIImage(named: "NLBLogo"))
		logoImageView.contentMode = UIViewContentMode.ScaleAspectFit

		usernameTextField = UITextField()
		usernameTextField.font = UIFont.systemFontOfSize(20)
		usernameTextField.placeholder = "Username"
		usernameTextField.leftView = UIImageView(image: UIImage(named: "User"))
		usernameTextField.leftViewMode = UITextFieldViewMode.Always
		usernameTextField.addBorder(edges: .Bottom, colour: UIColor.grayColor().colorWithAlphaComponent(0.7))
		usernameTextField.delegate = self

		passwordTextField = UITextField()
		passwordTextField.font = UIFont.systemFontOfSize(20)
		passwordTextField.placeholder = "Password"
		passwordTextField.secureTextEntry = true
		passwordTextField.leftView = UIImageView(image: UIImage(named: "Lock"))
		passwordTextField.leftViewMode = UITextFieldViewMode.Always
		passwordTextField.delegate = self

		loginButton = UIButton()
		loginButton.setTitle("Log In", forState: .Normal)
		loginButton.backgroundColor = UIColor.customPurple()
		loginButton.layer.cornerRadius = 5

		rememberMeSwitch = UISwitch()
		rememberMeSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
		rememberMeSwitch.onTintColor = UIColor.blueColor().colorWithAlphaComponent(0.8)

		rememberMeLabel = UILabel()
		rememberMeLabel.font = rememberMeLabel.font.fontWithSize(14)
		rememberMeLabel.text = "Remember Me"
		rememberMeLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.6)

		autoLoginSwitch = UISwitch()
		autoLoginSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
		autoLoginSwitch.onTintColor = UIColor.blueColor().colorWithAlphaComponent(0.8)

		autoLoginLabel = UILabel()
		autoLoginLabel.font = rememberMeLabel.font.fontWithSize(14)
		autoLoginLabel.text = "Auto Login"
		autoLoginLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.6)

		view.addSubview(logoImageView)
		view.addSubview(usernameTextField)
		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
		view.addSubview(rememberMeSwitch)
		view.addSubview(rememberMeLabel)
		view.addSubview(autoLoginSwitch)
		view.addSubview(autoLoginLabel)
	}

	override func setupConstraints() {
		let horizontalMargin = UIScreen.mainScreen().bounds.width / 8
		let topMargin = UIScreen.mainScreen().bounds.height / 7
		let imageHeight = (531 / (993 / (4 * horizontalMargin)))

		logoImageView.snp_makeConstraints { (make) in
			make.top.equalTo(self.view.snp_top).offset(topMargin)
			make.left.equalTo(self.view.snp_left).offset(2 * horizontalMargin)
			make.right.equalTo(self.view.snp_right).offset(2 * (-horizontalMargin))
			make.height.equalTo(imageHeight)
		}

		usernameTextField.snp_makeConstraints { (make) in
			make.top.equalTo(logoImageView.snp_bottom).offset(topMargin)
			make.left.equalTo(self.view.snp_left).offset(horizontalMargin)
			make.right.equalTo(self.view.snp_right).offset(-horizontalMargin)
			make.height.equalTo(40)
		}

		passwordTextField.snp_makeConstraints { (make) in
			make.top.equalTo(usernameTextField.snp_bottom)
			make.left.equalTo(usernameTextField.snp_left)
			make.right.equalTo(usernameTextField.snp_right)
			make.height.equalTo(40)
		}

		loginButton.snp_makeConstraints { (make) in
			make.top.equalTo(passwordTextField.snp_bottom).offset(20)
			make.left.equalTo(usernameTextField.snp_left)
			make.right.equalTo(usernameTextField.snp_right)
			make.height.equalTo(35)
		}

		rememberMeSwitch.snp_makeConstraints { (make) in
			make.top.equalTo(loginButton.snp_bottom).offset(10)
			make.right.equalTo(logoImageView.snp_right)
		}

		rememberMeLabel.snp_makeConstraints { (make) in
			make.top.equalTo(rememberMeSwitch.snp_top).offset(6)
			make.right.equalTo(rememberMeSwitch.snp_left)
		}

		autoLoginSwitch.snp_makeConstraints { (make) in
			make.top.equalTo(rememberMeSwitch.snp_bottom).offset(5)
			make.right.equalTo(rememberMeSwitch.snp_right)
		}

		autoLoginLabel.snp_makeConstraints { (make) in
			make.top.equalTo(autoLoginSwitch.snp_top).offset(6)
			make.right.equalTo(autoLoginSwitch.snp_left)
		}
	}

	func dismissKeyboard() {
		usernameTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
	}

	func fillTextFields() {

	}

	func animate(shouldAnimate: Bool) {

	}

	func showNextScreen() {

	}
}

extension LoginController: UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

}