//
//  WordListDataSource.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-29.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI

class WordListDataSource: ObservableObject {
    
    @Published var words: [Word] = WordManager.sharedInstance.getAllWordAlphabetical()
    
}
