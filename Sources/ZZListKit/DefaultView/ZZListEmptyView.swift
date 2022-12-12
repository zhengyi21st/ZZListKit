//
//  ZZListEmptyView.swift
//  ZZListKit
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import UIKit
import ZZComponents

open class ZZListEmptyView: UIView {
    
    open lazy var textLabel: UILabel = {
        $0.textColor = ZZColor.label
        $0.font = ZZFont.headline()
        $0.text = "No data"
        return $0
    }(UILabel())

    // MARK: init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = ZZColor.background
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
