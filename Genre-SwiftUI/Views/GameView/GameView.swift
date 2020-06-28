//
//  GameView.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-26.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var dataSource: GameViewDataSource
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            Button("Reset") {
                self.restartGame()
            }
            .padding()
            ZStack {
                ForEach(0..<self.dataSource.words.count, id: \.self) { i in
                    Card(word: self.dataSource.words[i])
                        .offset(self.dataSource.dragAmount[i])
                        .rotationEffect(.init(degrees: self.dataSource.degrees[i]))
                        .scaleEffect(self.dataSource.selectedCard == i ? 1 : 0.8)
                        .shadow(color: Color.black.opacity(0.07), radius: self.dataSource.selectedCard == i ? 10 : 5, x: 0, y: 2)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                            
                                    self.dataSource.dragAmount[i] = value.translation
                                    
                                    if abs(value.translation.width) > 20 {
                                        self.dataSource.degrees[i] = 5 * (value.translation.width > 0 ? 1 : -1)
                                    }
                                    else { self.dataSource.degrees[i] = 0 }
                            
                                }).onEnded({ (value) in
                            
                                    if value.translation.width > 0 {
                                        if value.translation.width > 100 {
                                            self.dataSource.dragAmount[i].width = 500
                                            self.dataSource.degrees[i] = 15
                                            self.dataSource.selectedCard -= 1
                                        }
                                        else {
                                            self.dataSource.dragAmount[i] = .zero
                                            self.dataSource.degrees[i] = 0
                                        }
                                    }
                                    else {
                                        if value.translation.width < -100 {
                                            self.dataSource.dragAmount[i].width = -500
                                            self.dataSource.degrees[i] = -15
                                            self.dataSource.selectedCard -= 1
                                        }
                                        else {
                                            self.dataSource.dragAmount[i] = .zero
                                            self.dataSource.degrees[i] = 0
                                        }
                                    }
                        }))
                }
            }.padding(10)
            .animation(.default)
        }
    }
    
    func restartGame() {
        dataSource.restartGame()
    }
}

struct Card: View {
    
    var word: Word
    
    var body: some View {
        VStack {
            Text(word.gender == true ? "Masc" : "Fem")
                .padding()
            Text(word.word ?? "")
                .font(.largeTitle)
                .padding()
            HStack(spacing: 25) {
                Button(action: {
                    
                }) {
                    Image(systemName: "hand.thumbsdown.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                }
                .background(Color.black.opacity(0.02))
                .clipShape(Circle())
                Button(action: {
                    
                }) {
                    Image(systemName: "hand.raised.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                }
                .background(Color.black.opacity(0.02))
                .clipShape(Circle())
                Button(action: {
                    
                }) {
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                }
                .background(Color.black.opacity(0.02))
                .clipShape(Circle())
            }
                .padding()
        }
        .frame(height: 300)
        .background(Color.white)
        .cornerRadius(25)
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(dataSource: GameViewDataSource())
    }
}

