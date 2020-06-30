//
//  WordList.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-29.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI

struct WordList: View {
    
    @ObservedObject var dataSource = WordListDataSource()
    
    var body: some View {
        List {
            ForEach(0..<self.dataSource.words.count, id: \.self) { i in
                Text(self.dataSource.words[i].word ?? "")
            }
        }.navigationBarTitle("Word List")
    }
}

struct WordList_Previews: PreviewProvider {
    static var previews: some View {
        WordList()
    }
}
