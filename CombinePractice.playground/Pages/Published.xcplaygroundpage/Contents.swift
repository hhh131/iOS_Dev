//: [Previous](@previous)

import Foundation
import UIKit
import Combine

final class SomeViewModel {
    @Published var name: String = "Jack"
    var age: Int = 20
}

final class Label {
    var text: String = ""
    var num: Int = 0
}

let label = Label()
let vm = SomeViewModel()

print("Text : \(label.text)")

vm.$name.assign(to: \.text, on: label) //
vm.age = 100
label.num = vm.age //!Published일 경우 값 변경시 직접 값을 재할당을 통해 값을 변경 해줘야 한다.

print("age : \(label.num)")

print("Text : \(label.text)")

vm.name = "Jason"
print("Text : \(label.text)")


vm.name = "Hoo"
print("Text : \(label.text)")
//: [Next](@next)
