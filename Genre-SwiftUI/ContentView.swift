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
        x = Array(repeating: 0.0, count: cardCount)
        degrees = Array(repeating: 0.0, count: cardCount)
    }

    @State var x : [CGFloat] = Array(repeating: 0.0, count: cardCount)
    var y: [CGFloat] = [0.0,-1.0,-2.0,-3.0,-4.0,-5.0]
    @State var degrees : [Double] = Array(repeating: 0.0, count: cardCount)
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ZStack {
                    ForEach(0..<cardCount, id: \.self) { i in
                        Card(offsets: self.x, index: i)
                            .offset(x: self.x[i], y:self.y[i]*4.0)
                            .rotationEffect(.init(degrees: self.degrees[i]))
                            .gesture(DragGesture().onChanged({ (value) in
                                
                                self.x[i] = value.translation.width
                                self.degrees[i] = 5 * (value.translation.width > 0 ? 1 : -1)
                                
                            }).onEnded({ (value) in
                                
                                if value.translation.width > 0 {
                                    if value.translation.width > 100 {
                                        self.x[i] = 500
                                        self.degrees[i] = 15
                                    }
                                    else {
                                        self.x[i] = 0
                                        self.degrees[i] = 0
                                    }
                                }
                                else {
                                    if value.translation.width < -100 {
                                        self.x[i] = -500
                                        self.degrees[i] = -15
                                    }
                                    else {
                                        self.x[i] = 0
                                        self.degrees[i] = 0
                                    }
                                }
                            }))
                    }
                }.padding(10)
                .animation(.default)
                Spacer()
                Button(action: {
                    self.resetState()
                }, label: {
                    Text("Reset")
                })
                .padding()
            }
        }
    }
}

struct Card: View {
    var offsets: [CGFloat]
    var index: Int
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
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

