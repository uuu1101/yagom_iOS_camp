//
//  GameStarter.swift
//  NumberBaseBall
//
//  Created by 김태형 on 2021/02/09.
//

import Foundation

struct GameStarter {

    var computer: Computer = Computer()
    var player: Player = Player()
    var computerAnswerSheet: [Int]
    var playerAnswerSheet: [Int]
    
    mutating func gameStart() {
        computerAnswerSheet = computer.createAnswerSheet()
        playerAnswerSheet = player.createAnswerSheet()
        
        print(computerAnswerSheet)
        print(playerAnswerSheet)
    }
}

