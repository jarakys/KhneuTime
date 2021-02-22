//
//  WeakObject.swift
//  KhneuTime
//
//  Created by Dmitro Kotelevets on 21.02.2021.
//

import Foundation

final class WeakObject<T>: Equatable {
    weak var _object: AnyObject?

    var object: T? {
        set { _object = newValue as AnyObject? }
        get { _object as? T }
    }

    init(_ object: T) {
        self.object = object
    }

    static func == (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
        lhs._object === rhs._object
    }
}

final class WeakObjectContainer<T> {
    private var container: [WeakObject<T>]

    var last: T? {
        container.last?.object
    }

    init() {
        container = [WeakObject<T>]()
    }

    init(objects: [T]) {
        container = [WeakObject<T>](objects.map { WeakObject($0) })
    }

    public func add(_ weakObject: T) {
        let anyObject = weakObject as AnyObject?
        if container.first(where: { $0._object === anyObject }) == nil {
            container.append(WeakObject(weakObject))
        }
        clean()
    }

    public func remove(_ weakObject: T) {
        let anyObject = weakObject as AnyObject?
        container = container.filter { !($0._object === anyObject) }
        clean()
    }

    public func enumerate(_ block: (T) -> Void) {
        container.compactMap { $0.object }.forEach { block($0) }
    }

    private func clean() {
        container = container.filter { $0._object != nil }
    }
}
