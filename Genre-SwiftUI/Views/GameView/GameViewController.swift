//
//  GameViewController.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-28.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI

class GameViewController: UIHostingController<GameView> {
    
    let wordManager = WordManager.sharedInstance
    
    override init(rootView: GameView) {
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWordsForGame()
    }
    
    func getWordsForGame() {
        print("Loading words for game")
        rootView.dataSource.words = self.wordManager.getRandomWordsFor(count: 10)
    }
}
