//
//  ZZRefreshAutoNormalFooter.swift
//  ZZListKit
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import Foundation
import MJRefresh

open class ZZRefreshAutoNormalFooter: MJRefreshAutoNormalFooter {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        isRefreshingTitleHidden = true
        setTitle("", for: .idle)
        triggerAutomaticallyRefreshPercent = 0
        mj_h = 56
    }
    
}
