//
//  ContentView.swift
//  X_and_O_Game_SwiftUI
//
//  Created by Kuat Bodikov on 03.12.2021.
//

import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameBoardDisable = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns){
                    ForEach(0..<9) {indexOfCircle in
                        ZStack {
                            Circle()
                                .foregroundColor(.blue).opacity(0.5)
                                .frame(width: geometry.size.width/3 - 15,
                                       height: geometry.size.width/3 - 15)
                            Image(systemName: moves[indexOfCircle]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: indexOfCircle) { return }
                            moves[indexOfCircle] = Move(player: .human, boardIndex: indexOfCircle)
                            isGameBoardDisable = true
                            
                            if checkWinCondition(for: .human, in: moves){
                                print("You win!")
                                return
                            }
                            
                            if checkingForDraw(in: moves){
                                print("Draw")
                                return
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let computerPosition = determinePositionForComputer(in: moves)
                                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                                isGameBoardDisable = false
                                
                                if checkWinCondition(for: .computer, in: moves){
                                    print("You lose!")
                                    return
                                }
                                
                                if checkingForDraw(in: moves){
                                    print("Draw")
                                    return
                                }
                            }
                            
                        }
                    }
                }
                Spacer()
            }
            .disabled(isGameBoardDisable)
            .padding()
        }
    }
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) ->Bool {
        return moves.contains { $0?.boardIndex == index}
    }
    
    func determinePositionForComputer(in moves: [Move?]) ->Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
              
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPattern: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player}
        let playerPostions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPattern where pattern.isSubset(of: playerPostions) {
            return true
        }
        return false
    }
    
    func checkingForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
}

enum Player {
    case human
    case computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
