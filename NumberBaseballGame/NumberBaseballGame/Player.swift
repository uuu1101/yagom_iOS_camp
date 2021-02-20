//
//  Player.swift
//  NumberBaseBall
//
//  Created by 김태형 on 2021/02/09.
//

import Foundation

struct Player {
    var answerSheet: [Int] = []
    
    mutating func createAnswerSheet() -> [Int] {
        answerSheet = []
        while answerSheet.count != 3 {
            print("숫자를 입력하세요 : ", terminator: "")
            let input = receiveInput()
            for answer in input {
                let finalAnswer = Int(answer!)
                answerSheet.append(finalAnswer)
            }
            if answerSheet.count != 3 {
                print("잘못된 입력 값입니다. 숫자 3개를 입력해주세요")
                answerSheet = []
            } else {
                answerSheet = checkOverlap()
            }
        }
        print(answerSheet)
        return answerSheet
    }
    
    func receiveInput() -> [Int?] {
        let number = readLine()!.split(separator: " ")
        let answer = number.map { Int($0) }
        
        return answer
    }
    
    mutating func checkOverlap() -> [Int] {
        if answerSheet[0] == answerSheet[1] || answerSheet[1] == answerSheet [2] || answerSheet[2] == answerSheet [0] {
            print("중복되는 값이 있습니다. 다시 입력해주세요.")
            answerSheet = []
        }
        return answerSheet
    }
}
