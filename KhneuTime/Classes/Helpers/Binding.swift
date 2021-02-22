import Foundation

@propertyWrapper
class Binding<Value> {

    private class Subscriber {
        let object: WeakObject<AnyObject>
        let callback: (Value) -> Void

        init(object: AnyObject, callback: @escaping (Value) -> Void) {
            self.object = WeakObject(object)
            self.callback = callback
        }
    }

    var value: Value
    private var subscribers = [Subscriber]()

    init(wrappedValue value: Value) {
        self.value = value
    }

    var projectedValue: Binding<Value> { self }

    var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            subscribers.removeAll(where: { $0.object.object == nil })
            subscribers.forEach { $0.callback(newValue) }
        }
    }

    public func subscribe(_ object: AnyObject, notifyCurrentState: Bool = false, callback: @escaping (Value) -> Void) {
        if subscribers.allSatisfy({ $0.object.object !== object }) {
            let subscriber = Subscriber(object: object, callback: callback)
            subscribers.append(subscriber)

            if notifyCurrentState {
                callback(value)
            }
        }
    }

    public func unsubscribe(_ object: AnyObject) {
        subscribers.removeAll(where: { $0.object.object === object })
    }
}
