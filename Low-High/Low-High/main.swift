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

let answer = Int(arc4random() % 100) + 1
var count = 0

while true {

    let userInput = readLine()

    guard let unwrappedInput = userInput, let inputNumber = Int(unwrappedInput) else {
        print("Wrong")
        continue
    }

    if inputNumber == answer {
        print("Correct! : \(count)")
        break
    }

    if inputNumber > answer {
        print("High")
    }

    if inputNumber < answer {
        print("Low")
    }

    count += 1
}
