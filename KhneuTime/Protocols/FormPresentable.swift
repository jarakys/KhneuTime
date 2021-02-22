//
//  FormPresentable.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 17.02.2021.
//

import Foundation

protocol FormPresentable: class {
    var formKey: String { get set }
}

extension FormPresentable {
    var formKey: String {
        get { "" }
        set { }
    }
}
