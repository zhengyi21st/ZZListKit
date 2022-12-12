//
//  ExampleViewModel.swift
//  ZZListKitExample
//
//  Created by Ethan on 2022/11/10.
//  Copyright © 2022 ZZListKit. All rights reserved.
//

import Foundation
import ZZListKit

class ExampleViewModel: NSObject, ZZListDataSource {

    weak var delegate: ZZListViewDelegate?

    var page: Int = 1

    var pageSize: Int = 20

    var list: [String] = []

    var attempt = 0

    func fetchList(completion: @escaping (Result<[String], Error>) -> Void) {
        attempt += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if self.attempt == 1 {
                completion(.failure(NSError()))
            } else {
                completion(.success(Array(repeating: "", count: 20)))
            }
        })
    }

}
