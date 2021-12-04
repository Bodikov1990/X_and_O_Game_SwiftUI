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
    @State private var isHumanTurn = true
    
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
                            moves[indexOfCircle] = Move(player: isHumanTurn ? .human : .computer, boardIndex: indexOfCircle)
                            isHumanTurn.toggle()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) ->Bool {
        return moves.contains { $0?.boardIndex == index}
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
