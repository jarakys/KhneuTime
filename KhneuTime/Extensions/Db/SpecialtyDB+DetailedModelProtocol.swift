//
//  SpecialtyDb.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 08.02.2021.
//

import Foundation

extension SpecialtyDB: DetailedModelProtocol {
    var idDetailed: Int {
        return Int(self.specialtyId)
    }
    
    var nameDetailed: String {
        return self.name ?? ""
    }
}
