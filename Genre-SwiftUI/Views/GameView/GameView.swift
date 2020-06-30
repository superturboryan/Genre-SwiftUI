//
//  GameView.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-26.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI
import Combine

enum GameViewAction {
    case restart
}

struct GameView: View {
    
    @ObservedObject var dataSource = GameViewDataSource()
    
    init() {
        dataSource.restartGame(withNewWords: true)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("\(self.dataSource.counter)")
                    ZStack {
                        ForEach(0..<self.dataSource.words.count, id: \.self) { i in
                            CardView(word: self.dataSource.words[i])
                                .offset(self.dataSource.dragAmount[i])
                                .rotationEffect(.init(degrees: self.dataSource.degrees[i]))
                                .scaleEffect(self.dataSource.currentQuestionIndex == i ? 1 : 0.8)
                                .shadow(color: Color.black.opacity(0.07), radius: self.dataSource.currentQuestionIndex == i ? 10 : 5, x: 0, y: 2)
                                .gesture(
                                    DragGesture()
                                        .onChanged({ (value) in
                                            self.dataSource.updateCardDragOnChanged(atIndex: i, with: value.translation)
                                        }).onEnded({ (value) in
                                            self.dataSource.updateCardDragOnEnded(atIndex: i, with: value.translation)
                                        }))
                        }
                    }
                    .padding(10)
                    .animation(.default)
                }
                
                
                    Button("New game") {
                        self.dataSource.restartGame(withNewWords:true)
                    }
                    .padding()
                    .offset(x: 0, y: self.dataSource.gameIsFinished ? 0 : 500)
                    .animation(.default)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    
    static var previews: some View {
        return GameView()
    }
}

