//
//  ZZListDefaultView.swift
//  ZZListKit
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import UIKit

open class ZZListDefaultView: UIView {
    
    @objc public dynamic var state: ZZListFetchState = .success {
        didSet {
            if oldValue != state {
                update(view: emptyView, for: .empty)
                update(view: loadingView, for: .loading)
                update(view: errorView, for: .error)
            }
        }
    }
    
    open var emptyViewType: UIView.Type {
        return ZZListEmptyView.self
    }

    
    open var loadingViewType: UIView.Type {
        return ZZListLoadingView.self
    }
    
    open var errorViewType: UIView.Type {
        return ZZListErrorView.self
    }
    
    public lazy var emptyView: UIView = emptyViewType.init()

    public lazy var loadingView: UIView = loadingViewType.init()

    public lazy var errorView: UIView = errorViewType.init()
    
    public var edgeInsets: UIEdgeInsets {
        return .zero
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        emptyView.frame = bounds
        loadingView.frame = bounds
        errorView.frame = bounds
    }
    
    private func commonInit() {
        update(view: emptyView, for: .empty)
        update(view: loadingView, for: .loading)
        update(view: errorView, for: .error)
    }
    
    private func update(view: UIView, for viewState: ZZListFetchState) {
        if viewState == state && view.superview != self {
            addSubview(view)
        } else if viewState != state && view.superview == self {
            view.removeFromSuperview()
        }
        isHidden = self.state == .success
    }
}
