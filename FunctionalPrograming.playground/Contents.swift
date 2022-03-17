import Foundation

let arr = [1, 2, 3, 4, 5]

func isEven(_ i: Int) -> Bool {
    return i % 2 == 0
}

let evens = arr.filter(isEven)

print(evens)

print(arr.filter{ $0 % 2 == 0 })
