//
//  Computer.swift
//  NumberBaseBall
//
//  Created by 김태형 on 2021/02/09.
//

import Foundation

struct Computer {
    var answerSheet: [Int] = []
    
    mutating func createAnswerSheet() -> [Int] {
        var numberOfAnswer = countNumberOfAnswer(answerSheet)

        while numberOfAnswer < 3 {
            answerSheet.append(createNumber())
            answerSheet = removeOverlap(answerSheet)
            numberOfAnswer = countNumberOfAnswer(answerSheet)
        }
        return answerSheet
    }
    
    private func createNumber() -> Int {
        let randomNumber: Int = Int.random(in: 1...9)
        return randomNumber
    }
    
    private func removeOverlap(_ answerSheet: [Int]) -> [Int] {
        let removedOverlapAnswerSheet = Set(answerSheet).map {$0}
        return removedOverlapAnswerSheet
    }
    
    private func countNumberOfAnswer(_ answerSheet: [Int]) -> Int {
        let countNumber = answerSheet.count
        return countNumber
    }
}
