import Foundation


// filter 함수 사용 예시
let arr = [1, 2, 3, 4, 5]

func isEven(_ i: Int) -> Bool {
    return i % 2 == 0
}

let evens = arr.filter(isEven)

// [2, 4]
print(evens)

// [2, 4]
print(arr.filter{ $0 % 2 == 0 })


// 함수를 반환하는 함수
func multiply(_ a: Int) -> (Int) -> Int {
    func multi(_ b: Int) -> Int {
        return a * b
    }
    return multi
}

let area = multiply(10)(20)

// 200
print(area)


func multiply2(_ a: Int) -> (Int) -> Int {
    return { b in
        return a * b
    }
}

let x10 = multiply(10)
let area2 = x10(20)

// 200
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

// 2
print(solution(array))


//MARK: - Composition (함수의 합성)

func f1(_ i: Int) -> Int {
    return i * 2
}

func f2(_ i: Int) -> String {
    return "\(i)"
}

let result = f2(f1(100))

// 200
print(result)

func ff(_ pf1: @escaping (Int) -> Int, _ pf2: @escaping (Int) -> String) -> (Int) -> String {
    return { i in
        return pf2(pf1(i))
    }
}

let f3 = ff(f1, f2)
let result3 = f3(100)

// 200
print(result3)

func comp<A, B, C>(_ pf1: @escaping (A) -> B, _ pf2: @escaping (B) -> C) -> (A) -> C {
    return { i in
        return pf2(pf1(i))
    }
}

let f4 = comp(f1, f2)
let result4 = f4(100)

// 200
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

// 12
print(solution1(numbers))

//MARK: - Currying 여러 개의 파라미터를 받는 함수를 하나의 파라미터를 받는 여러 개의 함수로 쪼개는 것
// 커링을 하는 이유!!!
// 함수의 Output이 다른 함수의 Input으로 연결되면서 합성(Composition)됩니다.
// 함수들이 서로 chain을 이루면서 연속적으로 연결이 되려면, Output과 Input의 타입과 개수가 같아야 합니다.
// 함수의 Output은 하나밖에 없으니 Input도 모두 하나씩만 갖도록 한다면 합성하기가 쉬워질 것입니다.
// 결국 함수의 합성을 원활하게 하기 위해서 커링을 사용하는 것 입니다.

func func0(_a: Int, _ b: Int) -> Int {
    return 0
}

func func1(_ a: Int) -> Int {
    return 0
}

func func2(_ b: Int) -> Int {
    return 0
}

let a1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]

func filterSum(_ ns: [Int], _ n: Int) -> Int {
    return ns.filter({ $0 % n == 0 }).reduce(0, +)
}

// 함수내부 구현
func filterSum2(_ n: Int) -> ([Int]) -> Int {
    return { ns in
        return ns.filter { $0 % n == 0 }.reduce(0, +)
    }
}

func solution2(_ nums: [Int], _ r: Int) -> Int {
    let filteredR = filterSum2(r)
    return filteredR(nums)
}


// 18
print(filterSum(a1, 3))

// 18
print(solution2(a1, 3))
