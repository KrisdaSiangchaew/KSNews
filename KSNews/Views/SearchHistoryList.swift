//
//  SearchHistoryList.swift
//  KSNews
//
//  Created by Kris on 10/6/2566 BE.
//

import SwiftUI

struct SearchHistoryList: View {
    @ObservedObject var searchModel: ArticleSearchViewModel
    
    let onSubmit: (String) -> Void
    
    var body: some View {
        List {
            HStack {
                Text("Recent Search")
                Spacer()
                Button("Clear all") {
                    searchModel.clearHistory()
                }
            }
            .listRowSeparator(.hidden)
            
            ForEach(searchModel.history, id: \.self) { text in
                Button(text) {
                    onSubmit(text)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        searchModel.removeFromHistory(text)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                }
            }
        }
        .listStyle(.plain)
    }
    
    func search() {
        Task {
            searchModel.searchArticle
        }
    }
}

struct SearchHistoryList_Previews: PreviewProvider {
    static let history = ["Apple", "Covid-19", "China"]
    static var previews: some View {
        SearchHistoryList(searchModel: ArticleSearchViewModel.shared, onSubmit: { _ in
            
        })
            .padding()
    }
}
