//
//  main.swift
//  FizzBuzz
//
//  Created by Suhyoung Eo on 2022/03/21.
//

//MARK: - FizzBuzz 프로그램
// 1 ~ 100 까지의 숫자를 출력하되,
// 3으로 나누어 떨어진다면 "fizz",
// 5로 나누어 떨어진다면 "buzz",
// 3과 5 둘 다 나누어 떨어지면 "fizzbuzz"를 출력하는 프로그램.

import Foundation

// 기본형
print("기본형 시작")

var i = 1
while i <= 100 {
    if i % 3 == 0 && i % 5 == 0 {
        print("fizzbuzz")
    } else if i % 3 == 0 {
        print("fizz")
    } else if i % 5 == 0 {
        print("buzz")
    } else {
        print(i)
    }
    
    i += 1
}

// 함수형
print("함수형 시작")

func fizz(_ i: Int) -> String {
    if i % 3 == 0 {
        return "fizz"
    }
    return ""
}

func buzz(_ i: Int) -> String {
    if i % 5 == 0 {
        return "buzz"
    }
    return ""
}

func fizzbuzz(_ i: Int) -> String {
    let f = fizz(i)
    let b = buzz(i)
    let result = f + b
    if result.isEmpty {
        return "\(i)"
    }
    return result
}

var j = 1 // 이부분이 변하므로 사이드 이펙트가 생김
while j <= 100 {
    let r = fizzbuzz(j)
    print(r)
    j += 1
}

// 사이드 이펙트 없는 함수형
print("사이드 이펙트 없는 함수형")

func fizz1(_ i: Int) -> String {
    if i % 3 == 0 {
        return "fizz"
    }
    return ""
}

func buzz1(_ i: Int) -> String {
    if i % 5 == 0 {
        return "buzz"
    }
    return ""
}

func fizzbuzz1(_ i: Int) -> String {
    let f = fizz1(i)
    let b = buzz1(i)
    let result = f + b
    if result.isEmpty {
        return "\(i)"
    }
    return result
}

func loop(min: Int, max: Int, do f: (Int) -> Void) {
    var i = min
    while i <= max {
        f(i)
        i += 1
    }
}

loop(min: 1, max: 100) { i in
    let r = fizzbuzz1(i)
    print(r)
}


// 사이드 이펙트 없는 함수형 간략하게 리펙토링
print("함수형 간략하게 리펙토링")

/* 클로져로 간단히 하기 */
// let fizz2: (Int) -> String = { i in i % 3 == 0 ? "fizz" : "" }
// let buzz2: (Int) -> String = { i in i % 5 == 0 ? "buzz" : "" }

/* 첫번째 */
// func fizzbuzz2(_ i: Int) -> String {
//     let result = fizz2(i) + buzz2(i)
//     return result.isEmpty ? "\(i)" : result
// }

/* 두번째 */
// func fizzbuzz2(_ i: Int) -> String {
//     let result = fizz2(i) + buzz2(i)
//     func ff(_ a: String, _ b: String) -> String {
//         return b.isEmpty ? a : b
//     }
//     return ff("\(i)", result)
// }

/* 세번째 */
// func fizzbuzz2(_ i: Int) -> String {
//     let result = fizz2(i) + buzz2(i)
//     let ff: (String, String) -> String = { a, b in b.isEmpty ? a : b }
//     return ff("\(i)", result)
// }

/* 네번째 */
// func fizzbuzz2(_ i: Int) -> String {
//     let result = fizz2(i) + buzz2(i)
//     return { a, b in b.isEmpty ? a : b }("\(i)", result)
// }

/* 다섯번째 */
// func fizzbuzz2(_ i: Int) -> String {
//     return { a, b in b.isEmpty ? a : b }("\(i)", fizz2(i) + buzz2(i))
// }

/* 여섯번째 */
// let fizzbuzz2: (Int) -> String = { i in { a, b in b.isEmpty ? a : b }("\(i)", fizz2(i) + buzz2(i))}

/* loop 간단히 하기*/
// func loop1(min: Int, max: Int, do f: (Int) -> Void) {
//     var i = min
//     while i <= max {
//         f(i)
//         i += 1
//     }
// }

// loop1(min: 1, max: 100, do: { i in
//     let r = fizzbuzz2(i)
//     print(r)
// })

// func loop1(min: Int, max: Int, do f: (Int) -> Void) {
//     Array(min...max).forEach(f)
// }
//
// loop1(min: 1, max: 100, do: { print(fizzbuzz2($0))})

/* 최종 */
let fizz2: (Int) -> String = { i in i % 3 == 0 ? "fizz" : "" }
let buzz2: (Int) -> String = { i in i % 5 == 0 ? "buzz" : "" }
let fizzbuzz2: (Int) -> String = { i in { a, b in b.isEmpty ? a : b }("\(i)", fizz2(i) + buzz2(i))}

func loop1(min: Int, max: Int, do f: (Int) -> Void) {
    Array(min...max).forEach(f)
}

loop1(min: 1, max: 100, do: { print(fizzbuzz2($0))})
