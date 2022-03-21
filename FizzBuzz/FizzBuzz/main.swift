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
