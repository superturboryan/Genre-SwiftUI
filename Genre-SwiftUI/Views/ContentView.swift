//
//  ContentView.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-26.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI

let cardCount = 6

struct ContentView: View {
    
    func resetState() {
        dragAmount = Array(repeating: .zero, count: cardCount)
        degrees = Array(repeating: 0.0, count: cardCount)
        self.selectedCard = 5
    }

    @State var dragAmount : [CGSize] = Array(repeating: .zero, count: cardCount)
    @State var degrees : [Double] = Array(repeating: 0.0, count: cardCount)
    @State var selectedCard : Int = cardCount - 1
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            Button("Reset") {
                self.resetState()
            }
            .padding()
            ZStack {
                ForEach(0..<cardCount, id: \.self) { i in
                    Card()
                        .offset(self.dragAmount[i])
                        .rotationEffect(.init(degrees: self.degrees[i]))
                        .scaleEffect(self.selectedCard == i ? 1 : 0.8)
                        .shadow(color: Color.black.opacity(0.07), radius: self.selectedCard == i ? 10 : 5, x: 0, y: 2)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                            
                                    self.dragAmount[i] = value.translation
                                    
                                    if abs(value.translation.width) > 20 {
                                        self.degrees[i] = 5 * (value.translation.width > 0 ? 1 : -1)
                                    }
                                    else { self.degrees[i] = 0 }
                            
                                }).onEnded({ (value) in
                            
                                    if value.translation.width > 0 {
                                        if value.translation.width > 100 {
                                            self.dragAmount[i].width = 500
                                            self.degrees[i] = 15
                                            self.selectedCard -= 1
                                        }
                                        else {
                                            self.dragAmount[i] = .zero
                                            self.degrees[i] = 0
                                        }
                                    }
                                    else {
                                        if value.translation.width < -100 {
                                            self.dragAmount[i].width = -500
                                            self.degrees[i] = -15
                                            self.selectedCard -= 1
                                        }
                                        else {
                                            self.dragAmount[i] = .zero
                                            self.degrees[i] = 0
                                        }
                                    }
                        }))
                }
            }.padding(10)
            .animation(.default)
        }
    }
}

struct Card: View {
    var body: some View {
        VStack {
            Text("Gender")
                .padding()
            Text("Word")
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

