//
//  CardView.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-28.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var word: Word
    
    var body: some View {
        VStack {
            Text(word.gender == true ? "Masc" : "Fem")
                .foregroundColor(.black)
                .padding()
            Text(word.word ?? "")
                .font(.largeTitle)
                .foregroundColor(.black)
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
            } // Buttons
                .padding()
        }
        .frame(height: 300)
        .background(Color.white)
        .cornerRadius(25)
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let randomWord = WordManager.sharedInstance
            .getRandomWordsFor(count: 1)
        return ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            CardView(word: randomWord.first!)
                .frame(width:200, height: 300)
        }
        .preferredColorScheme(.dark)
    }
}
