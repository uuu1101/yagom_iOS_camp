import Foundation

var winnerIsPlayer = false

func playRockPaperScissors(myValue: Int){
    
    let opponentValue = Int.random(in: 1...3)
    print(opponentValue)
    
    if myValue == opponentValue{
        print("비겼습니다!")
        gameStart()
        
    }else if (myValue == 1 && opponentValue == 2 ) ||
                (myValue == 2 && opponentValue == 3) ||
                (myValue == 3 && opponentValue == 1) {
        
        print("졌습니다!")
        winnerIsPlayer = false
        startMukchipa()
        
    }else{
        print("이겼습니다!")
        winnerIsPlayer = true
        startMukchipa()
    }
}
    

func gameStart(){
    print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")

    if let input = readLine(){
        switch input {
            case "1","2","3":
                if let myValue = Int(input) {playRockPaperScissors(myValue: myValue) }
                return

            case "0" :
                print("게임을 종료합니다.")
                return
                
            default:
                print("잘못된 입력입니다. 다시 시도해주세요.")
                gameStart()
        }
    }
}
gameStart()

func playMukchipa(myValue: Int){
    
    let opponentValue = Int.random(in: 1...3)
    print(opponentValue)
    
    if myValue == opponentValue{
        if winnerIsPlayer == true {
            print("사용자의 승리!")
        }else{
            print("컴퓨터의 승리!")
        }
        return
    
    }else if (myValue == 1 && opponentValue == 3 ) ||
                (myValue == 2 && opponentValue == 1) ||
                (myValue == 3 && opponentValue == 2) {
        winnerIsPlayer = false
        startMukchipa()
        
    }else{
        winnerIsPlayer = true
        startMukchipa()
    }
}

func startMukchipa(){
    if (winnerIsPlayer == true) {
        print("[사용자 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : ", terminator: "")
        
    }else {
        print("[컴퓨터 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : ", terminator: "")
    }
        if let input = readLine(){
            switch input {
                case "1", "2", "3" :
                    if let myValue = Int(input) {playMukchipa(myValue: myValue)}
                    return
                    
                case "0" :
                    print("게임을 종료합니다.")
                    return
                
                default:
                    print("잘못된 입력입니다. 다시 시도해주세요.")
                    startMukchipa()
            }
        }
}
