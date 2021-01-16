//
//  File.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

protocol StoryboardInstantiable {
}

extension StoryboardInstantiable where Self: UIViewController {
    static var className: String {
        return String(describing: Self.self)
    }
}
