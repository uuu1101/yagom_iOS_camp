//
//  GameStarter.swift
//  NumberBaseBall
//
//  Created by 김태형 on 2021/02/09.
//

import Foundation

class GameStarter {
    static let shared = GameStarter()
    private init() {}
    
    var modeNumber: String?
    var computer: Computer = Computer()
    var player: Player = Player()
    var computerAnswerSheet: [Int] = []
    var playerAnswerSheet: [Int] = []
    var strike: Int = 0
    var ball: Int = 0
    var opportunity: Int = 8
    
    func gameStart() {
        print("게임 시작 : 1 \n게임 종료 : 2")
        print("원하는 기능을 선택해주세요 : ", terminator: "")
        modeNumber = readLine()
        if modeNumber == "1"
        {
            while opportunity != 0 {
                strike = 0
                ball = 0
                computerAnswerSheet = computer.createAnswerSheet()
                playerAnswerSheet = player.createAnswerSheet()
                opportunity -= 1
                
                checkStrike(computerAnswerSheet, playerAnswerSheet)
                checkBall(computerAnswerSheet, playerAnswerSheet)
                
                playerAnswerSheet = []
                
                print("스트라이크 : \(strike), 볼 : \(ball)")
                print("남은 기회 : \(opportunity) 번")
                if strike == 3 {
                    print("Player 승리")
                    return
                }
                if opportunity == 0 {
                    print("Computer 승리")
                    return
                }
            }
        } else {
            print("게임을 종료합니다.")
        }
    }
    
    func checkStrike(_ computerAnswerSheet: [Int], _ playerAnswerSheet: [Int]) {
        if computerAnswerSheet[0] == playerAnswerSheet[0] {
            strike += 1
        }
        if computerAnswerSheet[1] == playerAnswerSheet[1] {
            strike += 1
        }
        if computerAnswerSheet[2] == playerAnswerSheet[2] {
            strike += 1
        }
    }
    
    func checkBall(_ computerAnswerSheet: [Int], _ playerAnswerSheet: [Int]) {
        if computerAnswerSheet[0] == playerAnswerSheet[1] {
            ball += 1
        }
        if computerAnswerSheet[0] == playerAnswerSheet[2] {
            ball += 1
        }
        if computerAnswerSheet[1] == playerAnswerSheet[0] {
            ball += 1
        }
        if computerAnswerSheet[1] == playerAnswerSheet[2] {
            ball += 1
        }
        if computerAnswerSheet[2] == playerAnswerSheet[0] {
            ball += 1
        }
        if computerAnswerSheet[2] == playerAnswerSheet[1] {
            ball += 1
        }
    }
}

GameStarter.shared.gameStart()

