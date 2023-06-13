//
//  SearchTab.swift
//  KSNews
//
//  Created by Kris on 7/6/2566 BE.
//

import SwiftUI

struct SearchTab: View {
    @StateObject var searchVM = ArticleSearchViewModel.shared
    
    var body: some View {
        ArticleList(articles: articles)
            .overlay(overlayView)
            .navigationTitle("Search")
            .searchable(text: $searchVM.searchQuery)
            .onSubmit(of: .search, search)
            .onChange(of: searchVM.searchQuery) { newValue in
                if newValue.isEmpty {
                    searchVM.phase = .empty
                }
            }
    }
    
    private var articles: [Article] {
        if case .success(let articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else if !searchVM.history.isEmpty {
                SearchHistoryList(searchModel: searchVM) { text in
                    searchVM.searchQuery = text
                    search()
                }
            } else {
                EmptyPlaceholder(text: "Type your query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
            }
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholder(text: "No search result found", image: Image(systemName: "magnifyingglass"))
        case .failure(let error):
            Retry(text: error.localizedDescription, retryAction: search)
        default: EmptyView()
        }
    }
    
    private func search() {
        let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            searchVM.saveToHistory(searchQuery)
        }
        Task {
            await searchVM.searchArticle()
        }
    }
}

struct SearchTab_Previews: PreviewProvider {
    @StateObject static var vm = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        SearchTab()
            .environmentObject(vm)
    }
}
