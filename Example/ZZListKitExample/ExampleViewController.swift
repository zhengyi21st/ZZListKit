//
//  ExampleViewController.swift
//  ZZListKitExample
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import UIKit
import ZZListKit

class ExampleViewController: UIViewController {

    var viewModel = ExampleViewModel()

    lazy var refreshHeader = ZZRefreshNormalHeader()

    lazy var refreshFooter = ZZRefreshAutoNormalFooter()

    lazy var defaultView = ZZListDefaultView()

    lazy var tableView: UITableView = {
        $0.delegate = self
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.tableFooterView = UIView()
        return $0
    }(UITableView(frame: .zero, style: .plain))

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.listInit()
    }

    private func setupUI () {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Action", style: .plain, target: self, action: #selector(handleAction))
        title = "ZZListKit"
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = UIColor.white
        }
        view.addSubview(tableView)
        tableView.addSubview(defaultView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        defaultView.snp.makeConstraints { make in
            make.top.left.width.height.equalToSuperview()
        }
    }

    @objc func handleAction() {
        let alert = UIAlertController(title: "Action", message: nil, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        alert.popoverPresentationController?.permittedArrowDirections = .any
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete index of 0", style: .default, handler: { _ in
            self.viewModel.listRemoveItem(at: 0)
        }))
        alert.addAction(UIAlertAction(title: "Delete all items", style: .default, handler: { _ in
            self.viewModel.listRemoveAllItems()
        }))
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - ZZListViewDelegate

extension ExampleViewController: ZZListViewDelegate {

    func listView() -> UIScrollView? {
        return tableView
    }

    func listViewForRefreshHeader() -> ZZRefreshHeader? {
        return refreshHeader
    }

    func listViewForRefreshFooter() -> ZZRefreshFooter? {
        return refreshFooter
    }

    func listViewForDefaultView() -> ZZListDefaultView? {
        return defaultView
    }

    func listViewDidUpdate() {
        tableView.reloadData()
    }

}

// MARK: - UITableViewDelegate && UITableViewDataSource

extension ExampleViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
