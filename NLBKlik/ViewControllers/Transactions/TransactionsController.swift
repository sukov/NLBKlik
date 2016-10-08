//
//  TransactionsController.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

//
//  ReservedFundsController.swift
//  NLBKlik
//
//  Created by WF | Gorjan Shukov on 10/6/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

class TransactionsController: BaseViewController, TransactionsView {
    private var presenter: TransactionsPresenter
    private var items: [[String: String]]?
    private var tableView: UITableView!
    private let cellID = "TransactionsCell"
    
    init(presenter: TransactionsPresenter) {
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
        super.setupViews()
        
        view.backgroundColor = UIColor.customGray()
        
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TransactionsCell.self, forCellReuseIdentifier: cellID)
        tableView.sectionHeaderHeight = 30
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.customGray()
        
        view.addSubview(tableView)
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
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        navigationItem.title = "Reserved funds"
    }
    
    func showItems(items: [[String: String]]) {
        self.items = items
        tableView.reloadData()
    }
    
    func showNextPageButton(shouldShow: Bool) {
        
    }
}

extension TransactionsController: UITableViewDelegate {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TransactionsTableHeaderView()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let amountHeight = TransactionsCell.calculateFontHeight((items?[indexPath.row])?[TransactionKeys.amount])
        let descHeight = TransactionsCell.calculateFontHeight((items?[indexPath.row])?[TransactionKeys.desc])
        return max(amountHeight, descHeight) + 5
    }
}

extension TransactionsController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! TransactionsCell
        cell.setContent(items?[indexPath.row])
        return cell
    }
    
}
