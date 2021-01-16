//
//  ReusableCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

protocol ReusableCell: class {
    static var reusableIndentify: String { get }
    static var nib: UINib { get }
}

extension ReusableCell {
    static var reusableIndentify: String{
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
