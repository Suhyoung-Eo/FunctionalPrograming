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


//MARK: - 고차함수를 사용하여 짝수만 합하기

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
