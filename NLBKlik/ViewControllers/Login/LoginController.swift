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
	private var scrollView: UIScrollView!
	private var contentView: UIView!
	private var activeField: UITextField?
	private var logoImageView: UIImageView!
	private var usernameTextField: UITextField!
	private var passwordTextField: UITextField!
	private var loginButton: UIButton!
	private var rememberMeLabel: UILabel!
	private var rememberMeSwitch: UISwitch!
	private var autoLoginLabel: UILabel!
	private var autoLoginSwitch: UISwitch!
	private var animationView: AnimationView!

	init(presenter: LoginPresenter) {
		self.presenter = presenter
		super.init()
		registerForKeyboardNotifications()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		deregisterFromKeyboardNotifications()
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		presenter.attachView(self)
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		presenter.detachView(self)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width)
	}

	override func setupViews() {
		super.setupViews()

		view.backgroundColor = UIColor.whiteColor()

		scrollView = UIScrollView()
		scrollView.scrollEnabled = false
		scrollView.delaysContentTouches = false
		scrollView.canCancelContentTouches = false

		contentView = UIView()
		contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

		logoImageView = UIImageView(image: UIImage(named: "NLBLogo"))
		logoImageView.contentMode = UIViewContentMode.ScaleAspectFit

		usernameTextField = UITextField()
		usernameTextField.tag = 0
		usernameTextField.font = UIFont.systemFontOfSize(20)
		usernameTextField.autocapitalizationType = UITextAutocapitalizationType.None
		usernameTextField.returnKeyType = UIReturnKeyType.Next
		usernameTextField.placeholder = "Username"
		usernameTextField.leftView = UIImageView(image: UIImage(named: "User"))
		usernameTextField.leftViewMode = UITextFieldViewMode.Always
		usernameTextField.addBorder(edges: .Bottom, colour: UIColor.grayColor().colorWithAlphaComponent(0.7))
		usernameTextField.autocorrectionType = .No
		usernameTextField.autocapitalizationType = .None
		usernameTextField.delegate = self

		passwordTextField = UITextField()
		passwordTextField.tag = 1
		passwordTextField.font = UIFont.systemFontOfSize(20)
		passwordTextField.returnKeyType = UIReturnKeyType.Go
		passwordTextField.placeholder = "Password"
		passwordTextField.secureTextEntry = true
		passwordTextField.leftView = UIImageView(image: UIImage(named: "Lock"))
		passwordTextField.leftViewMode = UITextFieldViewMode.Always
		passwordTextField.delegate = self

		loginButton = UIButton()
		loginButton.setTitle("Log In", forState: .Normal)
		loginButton.layer.cornerRadius = 5
		loginButton.backgroundColor = UIColor.customPurple()
		loginButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)

		rememberMeSwitch = UISwitch()
		rememberMeSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
		rememberMeSwitch.onTintColor = UIColor.customPurple()
		rememberMeSwitch.on = true
		rememberMeSwitch.addTarget(self,
			action: #selector(rememberMeSwitchChangedValue(_:)),
			forControlEvents: .ValueChanged)

		rememberMeLabel = UILabel()
		rememberMeLabel.font = rememberMeLabel.font.fontWithSize(14)
		rememberMeLabel.text = "Remember Me"
		rememberMeLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.6)

		autoLoginSwitch = UISwitch()
		autoLoginSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
		autoLoginSwitch.onTintColor = UIColor.customPurple()

		autoLoginLabel = UILabel()
		autoLoginLabel.font = rememberMeLabel.font.fontWithSize(14)
		autoLoginLabel.text = "Auto Login"
		autoLoginLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.6)

		animationView = AnimationView(frame: UIScreen.mainScreen().bounds)

		contentView.addSubview(logoImageView)
		contentView.addSubview(usernameTextField)
		contentView.addSubview(passwordTextField)
		contentView.addSubview(loginButton)
		contentView.addSubview(rememberMeSwitch)
		contentView.addSubview(rememberMeLabel)
		contentView.addSubview(autoLoginSwitch)
		contentView.addSubview(autoLoginLabel)
		scrollView.addSubview(contentView)
		view.addSubview(scrollView)
		view.addSubview(animationView)
	}

	override func setupConstraints() {
		super.setupConstraints()

		let horizontalMargin = UIScreen.mainScreen().bounds.width / 8
		let topMargin = UIScreen.mainScreen().bounds.height / 7
		let imageHeight = (531 / (993 / (4 * horizontalMargin)))

		scrollView.snp_makeConstraints { (make) in
			make.edges.equalTo(self.view)
		}

		contentView.snp_makeConstraints { (make) in
			make.edges.equalTo(scrollView)
			make.width.equalTo(scrollView.snp_width)
			make.height.equalTo(scrollView.snp_height)
		}

		logoImageView.snp_makeConstraints { (make) in
			make.top.equalTo(self.contentView.snp_top).offset(topMargin)
			make.left.equalTo(self.contentView.snp_left).offset(2 * horizontalMargin)
			make.right.equalTo(self.contentView.snp_right).offset(2 * (-horizontalMargin))
			make.height.equalTo(imageHeight)
		}

		usernameTextField.snp_makeConstraints { (make) in
			make.top.equalTo(logoImageView.snp_bottom).offset(topMargin)
			make.left.equalTo(self.contentView.snp_left).offset(horizontalMargin)
			make.right.equalTo(self.contentView.snp_right).offset(-horizontalMargin)
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
			make.height.equalTo(40)
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

//        let test = NetworkManager.sharedInstance.tempTest()
//        view.addSubview(test)
//        test.snp_makeConstraints { (make) in
//            make.left.right.bottom.equalTo(self.view)
//            make.top.equalTo(loginButton.snp_bottom)
//        }

	}

	func rememberMeSwitchChangedValue(sender: UISwitch) {
		if (sender.on) {
			autoLoginSwitch.enabled = true
		} else {
			autoLoginSwitch.enabled = false
		}
	}

	func dismissKeyboard() {
		usernameTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
	}

	func loginButtonTapped() {
		var userData = [String: AnyObject]()
		userData[UserDataKeys.username] = usernameTextField.text
		userData[UserDataKeys.password] = passwordTextField.text
		userData[UserDataKeys.rememberMe] = rememberMeSwitch.on
		userData[UserDataKeys.autoLogin] = (rememberMeSwitch.on == true) ? autoLoginSwitch.on : false
		presenter.login(userData)
	}

	func setContent(user: User) {
		usernameTextField.text = user.username
		passwordTextField.text = user.password
		rememberMeSwitch.on = true
		autoLoginSwitch.on = user.autoLogin
		if (autoLoginSwitch.on) {
			loginButtonTapped()
		}
	}

	func animate(shouldAnimate animate: Bool) {
		if (animate) {
			dismissKeyboard()
		}
		animationView.animate(animate)
	}

	func showNextScreen() {
		presentViewController(MainAssembly.sharedInstance.getMainController(), animated: true, completion: nil)
	}

	func showLoginError() {
		presentViewController(AlertFactory.loginError(), animated: true, completion: nil)
	}

	func showConnectionError() {
		let iOSVerzion = NSProcessInfo().operatingSystemVersion.majorVersion

		if (iOSVerzion <= 9) {
			presentViewController(AlertFactory.connectionError(), animated: true, completion: nil)
		} else {
			loginButton.userInteractionEnabled = false
			AlertFactory.connectionErrorIOS10 {
				self.loginButton.userInteractionEnabled = true
			}
		}
	}
}

extension LoginController: UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if (textField.tag == 0) {
			passwordTextField.becomeFirstResponder()
		} else {
			textField.resignFirstResponder()
			loginButtonTapped()
		}
		return true
	}

	func textFieldDidBeginEditing(textField: UITextField) {
		activeField = textField
	}

	func textFieldDidEndEditing(textField: UITextField) {
		activeField = nil
	}

	func registerForKeyboardNotifications() {
		// Adding notifies on keyboard appearing
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginController.keyboardWasShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
	}

	func deregisterFromKeyboardNotifications() {
		// Removing notifies on keyboard appearing
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
	}

	func keyboardWasShown(notification: NSNotification) {
		// Need to calculate keyboard exact size due to Apple suggestions
		self.scrollView.scrollEnabled = true
		let info: NSDictionary = notification.userInfo!
		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
		let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)

		self.scrollView.contentInset = contentInsets
		self.scrollView.scrollIndicatorInsets = contentInsets

		var aRect: CGRect = self.view.frame
		aRect.size.height -= keyboardSize!.height
		if let activeFieldPresent = activeField {
			if (!CGRectContainsPoint(aRect, activeFieldPresent.frame.origin)) {
				self.scrollView.scrollRectToVisible(activeFieldPresent.frame, animated: true)
			}
		}
	}

	func keyboardWillBeHidden(notification: NSNotification) {
		// Once keyboard disappears, restore original positions
		let info: NSDictionary = notification.userInfo!
		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
		let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
		self.scrollView.contentInset = contentInsets
		self.scrollView.scrollIndicatorInsets = contentInsets
		self.view.endEditing(true)
		self.scrollView.scrollEnabled = false
	}
}