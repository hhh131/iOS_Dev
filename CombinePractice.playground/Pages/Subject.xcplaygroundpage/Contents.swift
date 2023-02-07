import Foundation
import Combine

// PassthroughSubject
let relay = PassthroughSubject<String,Never>()
let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World")


// CurrentValueSubject
let variable = CurrentValueSubject<String,Never>("INIT_VAL")
variable.send("init_Val")
let subscription2 = variable.sink { value in
    print("subscription1 received value: \(value)")
}

variable.send("More text")
variable.value

let publisher = ["Here","We","Go"].publisher
publisher.subscribe(relay)

