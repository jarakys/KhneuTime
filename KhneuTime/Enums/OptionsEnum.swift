//
//  OptionsEnum.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 15.01.2021.
//

import Foundation

enum OptionsEnum: CaseIterable {
    case groups
    
    var description: String {
        switch self {
            case .groups:
                return "Groups"
        }
    }
    
    var iconName: String {
        String(describing: self)
    }
}
