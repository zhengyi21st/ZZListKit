//
//  ZZListLoadingView.swift
//  ZZListKit
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import UIKit
import ZZComponents

open class ZZListLoadingView: UIView {
    
    public var activityIndicatorView = UIActivityIndicatorView()
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if !self.isHidden && !activityIndicatorView.isAnimating {
            activityIndicatorView.startAnimating()
        } else if self.isHidden && activityIndicatorView.isAnimating {
            activityIndicatorView.stopAnimating()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = ZZColor.background
        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
