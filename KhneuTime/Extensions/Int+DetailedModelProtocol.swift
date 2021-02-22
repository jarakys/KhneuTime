//
//  Int+DetailedModelProtocol.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 21.02.2021.
//

import Foundation

extension Int: DetailedModelProtocol {
    var idDetailed: Int {
        self
    }
    
    var nameDetailed: String {
        self.description
    }
}
