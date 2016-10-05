//
//  MenuPresenter.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/5/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

import Foundation

protocol MenuPresenter {
	func attachView(view: MenuView)
	func detachView(view: MenuView)
}