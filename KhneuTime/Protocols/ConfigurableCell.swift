//
//  ConfigurableCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(item: DataType)
}

class ConfigurableViewCell<T>: UITableViewCell, ConfigurableCell {
    typealias DataType = T

    func configure(item: T) {
    }
}
