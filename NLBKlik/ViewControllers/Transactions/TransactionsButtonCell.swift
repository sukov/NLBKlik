//
//  TransactionsButtonCell.swift
//  NLBKlik
//
//  Created by Sukov on 10/8/16.
//  Copyright © 2016 WF | Gorjan Shukov. All rights reserved.
//

class TransactionsButtonCell: UITableViewCell {
    private var nextPageButton: UIButton!
    private var animationView: UIActivityIndicatorView!
    weak var delegate: TransactionButtonCellProtocol?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .clearColor()
        separatorInset = UIEdgeInsetsMake(0.0, bounds.width, 0.0, 0.0)
        
        animationView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        animationView.color = UIColor.customPurple()
        
        nextPageButton = UIButton()
        nextPageButton.setTitle("Load Next Page", forState: .Normal)
        nextPageButton.layer.cornerRadius = 5
        nextPageButton.backgroundColor = UIColor.customPurple()
        nextPageButton.addTarget(self, action: #selector(nextPageButtonTapped), forControlEvents: .TouchUpInside)
        
        addSubview(nextPageButton)
        addSubview(animationView)
    }
    
    override func prepareForReuse() {
        nextPageButton.hidden = false
        animationView.stopAnimating()
    }
    
    func set() {
        nextPageButton.hidden = true
        animationView.startAnimating()
    }
    
    func setupConstraints() {
        let insets = (UIScreen.mainScreen().bounds.width / 6)
        
        nextPageButton.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.left.right.equalTo(self).inset(insets)
        }
        
        animationView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.left.equalTo(insets * 2.75)
        }
    }
    
    func nextPageButtonTapped() {
        nextPageButton.hidden = true
        animationView.startAnimating()
        delegate?.nextPageButtonTapped()
    }
}

@objc protocol TransactionButtonCellProtocol {
    func nextPageButtonTapped()
}
    