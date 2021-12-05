//
//  ContentView.swift
//  X_and_O_Game_SwiftUI
//
//  Created by Kuat Bodikov on 03.12.2021.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: viewModel.columns){
                    ForEach(0..<9) {indexOfSquare in
                        ZStack {
                            GameCircleView(proxy: geometry)
                            
                            PlayerIndexes(systemImageName: viewModel.moves[indexOfSquare]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processPlayerMoving(in: indexOfSquare)
                            
                        }
                    }
                }
                Spacer()
            }
            .disabled(viewModel.isGameBoardDisable)
            .padding()
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { viewModel.buttonForResetGame()}))
            }
        }
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
        GameView()
    }
}

struct GameCircleView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.blue).opacity(0.5)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndexes: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
