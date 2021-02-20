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
        while answerSheet.count != 3 {
            print("숫자를 입력하세요 : ", terminator: "")
            let input = receiveInput()
            answerSheet.append(contentsOf: input.startIndex...input.endIndex)
            answerSheet = Set(answerSheet).map{$0}
            
            if answerSheet.count != 3 {
                print("잘못된 입력 값입니다. 숫자 3개를 입력해주세요")
            }
        }
        return answerSheet
    }
    
    func receiveInput() -> [Int?] {
        let number = readLine()!.components(separatedBy: "")
        let answer = number.map { Int($0) }
        
        return answer
    }
}
