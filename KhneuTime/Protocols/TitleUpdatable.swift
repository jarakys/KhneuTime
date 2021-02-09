//
//  TitleUpdatable.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 07.02.2021.
//

import Foundation

@objc protocol Updatable {
    func updateTitle(title: String)
    func updateData(subsectionId: Int)
}
