//: [Previous](@previous)

import Foundation
import Combine

let subject = PassthroughSubject<String,Never>()



// The print() operator prints you all lifecycle events
let subscription = subject.print().sink { value in
    print("Subscriber received value \(value)")
}

subject.send("hello")
subject.send("hello again")
subject.send("asdasdjkl")
//subject.send(completion: .finished)
subscription.cancel()
subject.send("Asdasds")
//: [Next](@next)
