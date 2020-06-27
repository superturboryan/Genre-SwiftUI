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

    @State var x : [CGFloat] = Array(repeating: 0.0, count: cardCount)
    @State var degrees : [Double] = Array(repeating: 0.0, count: cardCount)
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            ZStack {
                ForEach(0..<cardCount, id: \.self) { i in
                    Card(text: "First word")
                        .offset(x: self.x[i])
                        .rotationEffect(.init(degrees: self.degrees[i]))
                        .gesture(DragGesture().onChanged({ (value) in
                      
                            self.x[i] = value.translation.width
                            self.degrees[i] = 8
                            
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
        }
        
    }
}

struct Card: View {
    var text: String
    var body: some View {
        VStack {
            Text("Gender")
                .padding()
            Text("Word")
                .font(.largeTitle)
                .padding()
            HStack(spacing: 25) {
                Button(action: {
                    //Action
                }) {
                    
                    Image(systemName: "message.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                }
                .background(Color.black.opacity(0.02))
                .clipShape(Circle())
                Button(action: {
                    //Action
                }) {
                    
                    Image(systemName: "message.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                }
                .background(Color.black.opacity(0.02))
                .clipShape(Circle())
                Button(action: {
                    //Action
                }) {
                    
                    Image(systemName: "message.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                }
                .background(Color.black.opacity(0.02))
                .clipShape(Circle())
                Button(action: {
                    //Action
                }) {
                    
                    Image(systemName: "message.fill")
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

