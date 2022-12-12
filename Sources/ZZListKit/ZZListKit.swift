//
//  ZZListKit.swift
//  ZZListKit
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import Foundation
import MJRefresh

public typealias ZZRefreshHeader = MJRefreshHeader

public typealias ZZRefreshFooter = MJRefreshFooter

@objc public enum ZZListFetchState: Int {
    /// 成功状态
    case success
    /// 加载状态
    case loading
    /// 错误状态
    case error
    /// 空状态
    case empty
}
