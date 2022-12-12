//
//  ZZListDataSource.swift
//  ZZListKit
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import Foundation
import MJRefresh

public protocol ZZListDataSource: AnyObject {
    associatedtype Item
    var delegate: ZZListViewDelegate? { get }
    var page: Int { get set }
    var pageSize: Int { get }
    var list: [Item] { get set }
    func fetchList(completion: @escaping (Result<[Item], Error>) -> Void)
}

public extension ZZListDataSource {
    
    func listInit() {
        let tempPage = page
        let defaultView = delegate?.listViewForDefaultView()
        page = 1
        defaultView?.state = .loading
        fetchList { result in
            switch result {
            case .success(let items):
                if items.isEmpty {
                    self.list = items
                    self.delegate?.listViewDidUpdate()
                    self.addRefreshHeaderIfNeeded()
                    defaultView?.state = .empty
                } else {
                    self.list = items
                    self.delegate?.listViewDidUpdate()
                    self.addRefreshHeaderIfNeeded()
                    self.addRefreshFooterIfNeeded()
                    defaultView?.state = .success
                    if items.count < self.pageSize {
                        self.delegate?.listViewForRefreshFooter()?.endRefreshingWithNoMoreData()
                    }
                }
            case .failure:
                self.page = tempPage
                defaultView?.state = .error
                self.addRefreshHeaderIfNeeded()
                self.delegate?.listViewDidUpdate()
            }
        }
    }
    
    func listRefresh() {
        let tempPage = page
        let refreshHeader = delegate?.listViewForRefreshHeader()
        let refreshFooter = delegate?.listViewForRefreshFooter()
        let defaultView = delegate?.listViewForDefaultView()
        page = 1
        fetchList { result in
            switch result {
            case .success(let items):
                // 刷新数据成功
                self.list = items
                self.delegate?.listViewDidUpdate()
                refreshHeader?.endRefreshing()
                self.addRefreshFooterIfNeeded()
                defaultView?.state = items.isEmpty ? .empty: .success
                if items.count < self.pageSize {
                    refreshFooter?.endRefreshingWithNoMoreData()
                } else {
                    refreshFooter?.resetNoMoreData()
                }
            case .failure:
                // 刷新数据失败
                self.page = tempPage
                refreshHeader?.endRefreshing()
            }
        }
    }
    
    func listLoadMore() {
        let tempPage = page
        let refreshFooter = delegate?.listViewForRefreshFooter()
        page += 1
        fetchList { result in
            switch result {
            case .success(let items):
                if items.count >= self.pageSize {
                    self.list += items
                    self.delegate?.listViewDidUpdate()
                    refreshFooter?.endRefreshing()
                } else {
                    self.list += items
                    self.delegate?.listViewDidUpdate()
                    refreshFooter?.endRefreshingWithNoMoreData()
                }
            case .failure:
                self.page = tempPage
                refreshFooter?.endRefreshing()
            }
        }
    }
    
    func listRemoveItem(at index: Int) {
        guard index < list.count else { return }
        list.remove(at: index)
        self.delegate?.listViewDidUpdate()
        if list.isEmpty {
            delegate?.listViewForDefaultView()?.state = .empty
            delegate?.listView()?.mj_footer = nil
        }
    }
    
    func listRemoveAllItems() {
        list = []
        self.delegate?.listViewDidUpdate()
        delegate?.listViewForDefaultView()?.state = .empty
        delegate?.listView()?.mj_footer = nil
    }
}


private extension ZZListDataSource {
    
    func addRefreshHeaderIfNeeded() {
        let listView = delegate?.listView()
        if listView?.mj_header == nil {
            let refreshHeader = delegate?.listViewForRefreshHeader()
            listView?.mj_header = refreshHeader
            refreshHeader?.refreshingBlock = {[weak self] in
                self?.listRefresh()
            }
        }
    }
    
    func addRefreshFooterIfNeeded() {
        let listView = delegate?.listView()
        if listView?.mj_footer == nil {
            let refreshFooter = delegate?.listViewForRefreshFooter()
            listView?.mj_footer = refreshFooter
            refreshFooter?.refreshingBlock = {[weak self] in
                self?.listLoadMore()
            }
        }
    }
    
}
