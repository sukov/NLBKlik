//
//  MainController.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/5/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import UIKit

class MainController: SWRevealViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		revealViewController()
		view.addGestureRecognizer(panGestureRecognizer())
		rearViewRevealWidth = UIScreen.mainScreen().bounds.width / 1.5
		rearViewRevealOverdraw = 0
        view.backgroundColor = .whiteColor()
		
        (rearViewController as! MenuController).viewControllers.append(frontViewController)
        (rearViewController as! MenuController).viewControllers.append(MainAssembly.sharedInstance.getTransactionsController())
        (rearViewController as! MenuController).viewControllers.append(MainAssembly.sharedInstance.getReservedFundsController())
	}
}
