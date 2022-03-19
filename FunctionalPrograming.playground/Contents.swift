import Foundation


// filter 함수 사용 예시
let arr = [1, 2, 3, 4, 5]

func isEven(_ i: Int) -> Bool {
    return i % 2 == 0
}

let evens = arr.filter(isEven)

print(evens)

print(arr.filter{ $0 % 2 == 0 })


// 함수를 반환하는 함수
func multiply(_ a: Int) -> (Int) -> Int {
    func multi(_ b: Int) -> Int {
        return a * b
    }
    return multi
}

let area = multiply(10)(20)

print(area)


func multiply2(_ a: Int) -> (Int) -> Int {
    return { b in
        return a * b
    }
}

let x10 = multiply(10)
let area2 = x10(20)

print(area2)


//MARK: - Higher-Order Function (고차함수를 사용하여 짝수만 합하기)

let array: [Int] = [1, 2, 3]

// 함수 내부 구현
// let f: (Int) -> Bool = { even in
//     return even % 2 == 0
// }

// 함수 내부 구현
// let s: (Int, Int) -> Int = { a, b in
//     return a + b
// }

// 더 간단하게
let f: (Int) -> Bool = { even in even % 2 == 0 }
let s: (Int, Int) -> Int = { a, b in a + b }

func solution(_ nums: [Int]) -> Int {
    return nums.filter(f).reduce(0, s)
}

print(solution(array))


//MARK: - Composition (함수의 합성)

func f1(_ i: Int) -> Int {
    return i * 2
}

func f2(_ i: Int) -> String {
    return "\(i)"
}

let result = f2(f1(100))

print(result)

func ff(_ pf1: @escaping (Int) -> Int, _ pf2: @escaping (Int) -> String) -> (Int) -> String {
    return { i in
        return pf2(pf1(i))
    }
}

let f3 = ff(f1, f2)
let result3 = f3(100)

print(result3)

func comp<A, B, C>(_ pf1: @escaping (A) -> B, _ pf2: @escaping (B) -> C) -> (A) -> C {
    return { i in
        return pf2(pf1(i))
    }
}

let f4 = comp(f1, f2)
let result4 = f4(100)

print(result4)

/* 함수내부 구현*/

let numbers = [ 1, 2, 3, 4, 6]

func filterEven(_ nums: [Int]) -> [Int] {
    return nums.filter { $0 % 2 == 0 }
}

func sum(_ nums: [Int]) -> Int {
    return nums.reduce(0, +)
}

let filteredSum = comp(filterEven, sum)

func solution1(_ nums: [Int]) -> Int {
    return filteredSum(nums)
}

print(solution1(numbers))
