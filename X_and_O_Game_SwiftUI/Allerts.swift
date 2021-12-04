//
//  Allerts.swift
//  X_and_O_Game_SwiftUI
//
//  Created by Kuat Bodikov on 04.12.2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin     = AlertItem(title: Text("Ты выйграл!"),
                                        message: Text("Ты победил свой ИИ"),
                                        buttonTitle: Text("Молодец"))
    
    static let computerWin  = AlertItem(title: Text("Ты проиграл!"),
                                        message: Text("Твой ИИ победил тебя"),
                                        buttonTitle: Text("Реванш"))
    
    static let draw         = AlertItem(title: Text("Ничья!"),
                                        message: Text("Достойная игра"),
                                        buttonTitle: Text("Повторим?!"))
}
