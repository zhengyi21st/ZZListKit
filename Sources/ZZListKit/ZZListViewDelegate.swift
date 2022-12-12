//
//  ZZListViewDelegate.swift
//  ZZListKit
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import Foundation
import MJRefresh

public protocol ZZListViewDelegate: AnyObject {
    func listView() -> UIScrollView?
    func listViewForRefreshHeader() -> ZZRefreshHeader?
    func listViewForRefreshFooter() -> ZZRefreshFooter?
    func listViewForDefaultView() -> ZZListDefaultView?
    func listViewDidUpdate()
}
