//
//  FacultyDB+DetailedModelProtocol.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 07.02.2021.
//

import Foundation

extension FacultyDB: DetailedModelProtocol {
    var idDetailed: Int {
        return Int(self.id)
    }
    
    var nameDetailed: String {
        return self.name ?? ""
    }
}
