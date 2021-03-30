//
//  AsynchronousOperation.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 06.02.2021.
//

import Foundation

open class AsynchronousOperation: Operation {
    public override var isAsynchronous: Bool {
        return true
    }
    
    public override var isExecuting: Bool {
        return state == .executing
    }
    
    public override var isFinished: Bool {
        return state == .finished
    }
    
    var block: (()->Void)?
    
    public override func start() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .ready
            main()
        }
    }
    
    open override func main() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .executing
        }
        state = .finished
    }
    
    public func finish() {
        state = .finished
    }
    
    // MARK: - State management
    
    public enum State: String {
        case ready = "Ready"
        case executing = "Executing"
        case finished = "Finished"
        fileprivate var keyPath: String { return "is" + self.rawValue }
    }
    
    public var state: State {
        get {
            stateQueue.sync {
                return stateStore
            }
        }
        set {
            let oldValue = state
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
            stateQueue.sync(flags: .barrier) {
                stateStore = newValue
            }
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    private let stateQueue = DispatchQueue(label: "AsynchronousOperation_State_Queue", attributes: .concurrent)
    
    private var stateStore: State = .ready
}


final class NetworkAsyncOperation: AsynchronousOperation {
    
    let route: APIRouter
    let entity: SyncEntitiesEnum
    
    init(route: APIRouter, entity: SyncEntitiesEnum) {
        self.route = route
        self.entity = entity
        super.init()
    }
    
     override func main() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .executing
        }
        NetworkManager.shared.sendRequest(route: route, completion: {result in
            if case let .success(data) = result {
                DatabaseManager.shared.insertOrUpdateObject(entity: self.entity, data: data)
            }
            self.state = .finished
            self.block?()
        })
    }
}
