//
//  GameViewController.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-28.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI
import Combine

class GameViewController: UIHostingController<GameView> {
    
    let wordManager = WordManager.sharedInstance
    var reducer: Cancellable?
    
    override init(rootView: GameView) {
        super.init(rootView: rootView)
        configureReducerActions()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWordsForGame()
    }
    
    func getWordsForGame() {
        rootView.dataSource.words = wordManager.getRandomWordsFor(count: 10)
    }
    
    func configureReducerActions() {
        self.reducer = rootView.gameViewActionPublisher.sink { (action) in
            switch(action) {
            case .restart:
                self.getWordsForGame()

            }
        }
    }
}
