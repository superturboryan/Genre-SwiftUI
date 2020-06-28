//
//  GameViewDataSource.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-28.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI

class GameViewDataSource: ObservableObject {
    
    @Published var words = [Word]() {
        didSet {
            dragAmount = Array(repeating: .zero, count: words.count)
            degrees = Array(repeating: 0.0, count: words.count)
            selectedCard = words.count-1
        }
    }

    @Published var dragAmount = [CGSize]()
    @Published var degrees = [Double]()
    @Published var selectedCard = 0
    
    func restartGame() {
        dragAmount = Array(repeating: .zero, count: words.count)
        degrees = Array(repeating: 0.0, count: words.count)
        selectedCard = words.count-1
    }
}
