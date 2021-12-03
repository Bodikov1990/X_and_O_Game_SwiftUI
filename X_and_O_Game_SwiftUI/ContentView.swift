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
    
    var body: some View {
        
        LazyVGrid(columns: columns){
            Text("Kuat")
            Text("Kuat")
            Text("Kuat")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
