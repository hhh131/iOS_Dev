//: [Previous](@previous)

import Foundation
import Combine

// Transform - Map
let numPublisher = PassthroughSubject<Int,Never>()
let subscription1 = numPublisher
    .map{ $0 * 2}
    .sink{
        value in
        print("Transfoms Value: \(value)")
    }

numPublisher.send(10)
numPublisher.send(30)
numPublisher.send(20)


// Filter
let stringPubliser = PassthroughSubject<String,Never>()
let subscription2 = stringPubliser
    .filter{
        $0.contains("a")
    }
    .sink { value in
        print("Flitered value \(value)")
    }
stringPubliser.send("abc")
stringPubliser.send("dsd")
stringPubliser.send("Jack")
stringPubliser.send("John")
subscription2.cancel()
//: [Next](@next)
