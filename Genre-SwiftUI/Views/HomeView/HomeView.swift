//
//  HomeView.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-28.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI
import Combine

enum HomeViewAction {
    case goToNewGame
    case goToWordList
}

struct HomeView: View {
    
    @State var playingGame = false
    
    let mainMenuActions = PassthroughSubject<HomeViewAction,Never>()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.gray)
                VStack {
                    Spacer()
                    Button("New game") {
                        self.playingGame.toggle()
                    }.sheet(isPresented: $playingGame) {
                        GameView()
                    }
                    Spacer()
                    NavigationLink(destination: WordList()) {
                        Text("Word List")
                    }
                    Spacer()
                }
                .frame(width: 300, height: 400)
                .background(Color.white)
                .cornerRadius(25)
            }
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
