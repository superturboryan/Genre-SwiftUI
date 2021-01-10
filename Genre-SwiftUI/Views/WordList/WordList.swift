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
    
    let columns = [
        GridItem(.flexible(minimum:10, maximum:200)),
        GridItem(.flexible(minimum:10, maximum:200)),
        GridItem(.flexible(minimum:10, maximum:200)),
        GridItem(.flexible(minimum:10, maximum:200)),
    ]
    
    var body: some View {
        ScrollView {
            HStack {
                Text("\(dataSource.words.count) words")
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                Spacer()
            }
            LazyVGrid(columns:columns, spacing:50) {
                ForEach(0..<self.dataSource.words.count,
                        id: \.self) {
                    i in
                    Text(self.dataSource.words[i].word ?? "")
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .padding(10.0)
                        .background(self.dataSource.words[i].gender ? Color.blue : Color.purple)
                        .cornerRadius(5.0)
                }
            }
        }.navigationBarTitle("Word List")

    }
}

struct WordList_Previews: PreviewProvider {
    static var previews: some View {
        WordList()
            .preferredColorScheme(.dark)
    }
}
