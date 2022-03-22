//
//  main.swift
//  Low-High
//
//  Created by Suhyoung Eo on 2022/03/22.
//

// Low-High는 사용자로부터 숫자를 입력받아 랜덤(1~100)으로 생성된 값과 비교하여,
// 큰 값이 입력되면 High
// 작은 값이 입력되면 Low
// 같으면 Correct! 를 출력합니다.
// Correct 출력 시 시도했던 횟수를 함께 출력합니다.
// 수행은 Correct가 될 때까지 무한반복됩니다.
// 숫자가 입력되지 않으면 Wrong 을 출력합니다.


import Foundation

// let answer = Int(arc4random() % 100) + 1
// var count = 0    // 이부분에서 사이드 이펙트 생김
//
// while true {
//
//     let userInput = readLine()
//
//     guard let unwrappedInput = userInput, let inputNumber = Int(unwrappedInput) else {
//         print("Wrong")
//         continue
//     }
//
//     if inputNumber == answer {
//         print("Correct! : \(count)")
//         break
//     }
//
//     if inputNumber > answer {
//         print("High")
//     }
//
//     if inputNumber < answer {
//         print("Low")
//     }
//
//     count += 1
// }

/* 첫번째 */

// let answer = Int(arc4random() % 100) + 1
// let answer = 50
//
// func inputAndCheck() -> Bool {
//     let userInput = readLine()
//
//     guard let unwrappedInput = userInput, let inputNumber = Int(unwrappedInput) else {
//         print("Wrong")
//         return true
//     }
//
//     if inputNumber == answer {
//         return false
//     }
//
//     if inputNumber > answer {
//         print("High")
//     }
//
//     if inputNumber < answer {
//         print("Low")
//     }
//
//     return true
// }
//
// func countingLoop(_ needCountinue: () -> Bool) {
//     var count = 0
//     while true {
//         if !needCountinue() { break }
//         count += 1
//     }
//     print("Correct! : \(count)")
// }
//
// countingLoop(inputAndCheck0)

/* 두번째 */

// let answer = 50
//
// func inputAndCheck() -> Bool {
//     let userInput = readLine()
//
//     guard let unwrappedInput = userInput, let inputNumber = Int(unwrappedInput) else {
//         print("Wrong")
//         return true
//     }
//
//     if inputNumber == answer {
//         return false
//     }
//
//     if inputNumber > answer {
//         print("High")
//     }
//
//     if inputNumber < answer {
//         print("Low")
//     }
//
//     return true
// }
//
// func corrected(_ count: Int) -> Void {
//     print("Correct! : \(count)")
// }
//
// func countingLoop(_ needCountinue: @escaping () -> Bool, _ finished: (Int) -> Void) {
//
//     func counter(_ c: Int) -> Int {
//         if !needCountinue() { return c }
//         return counter(c + 1)
//     }
//
//     finished(counter(0))
// }
//
// countingLoop(inputAndCheck, corrected)

/* 세번째 */

// let answer = 50
//
// enum Result: String {
//     case wrong = "Wrong"
//     case correct = "Correct!"
//     case high = "High"
//     case low = "Low"
// }
//
// func inputAndCheck() -> Bool {
//     return printResult(evaluateInput())
// }
//
// func evaluateInput() -> Result {
//     guard let InputNumber = Int(readLine() ?? "") else { return .wrong }
//     if InputNumber > answer { return .high}
//     if InputNumber < answer { return .low }
//     return .correct
// }
//
// func printResult( _ r: Result) -> Bool {
//     if case .correct = r { return false }
//     print(r.rawValue)
//     return true
// }
//
// func corrected(_ count: Int) -> Void {
//     print("Correct! : \(count)")
// }
//
// func countingLoop(_ needCountinue: @escaping () -> Bool, _ finished: (Int) -> Void) {
//
//     func counter(_ c: Int) -> Int {
//         if !needCountinue() { return c }
//         return counter(c + 1)
//     }
//
//     finished(counter(0))
// }
//
// countingLoop(inputAndCheck, corrected)

/* 네번째 */

enum Result: String {
    case wrong = "Wrong"
    case correct = "Correct!"
    case high = "High"
    case low = "Low"
}

func generateAnswer(_ min: Int, _ max: Int) -> Int {
    return Int(arc4random()) % (max - min) + min
}

func inputAndCheck(_ answer: Int) -> () -> Bool {
    return { printResult(evaluateInput(answer)) }
}

func evaluateInput(_ answer: Int) -> Result {
    guard let InputNumber = Int(readLine() ?? "") else { return .wrong }
    if InputNumber > answer { return .high}
    if InputNumber < answer { return .low }
    return .correct
}

func printResult( _ r: Result) -> Bool {
    if case .correct = r { return false }
    print(r.rawValue)
    return true
}

func corrected(_ count: Int) -> Void {
    print("Correct! : \(count)")
}

func countingLoop(_ needCountinue: @escaping () -> Bool, _ finished: (Int) -> Void) {
    
    func counter(_ c: Int) -> Int {
        if !needCountinue() { return c }
        return counter(c + 1)
    }
    
    finished(counter(0))
}

countingLoop(inputAndCheck(generateAnswer(1, 100)), corrected)

