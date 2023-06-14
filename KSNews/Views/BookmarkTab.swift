//
//  BookmarkTab.swift
//  KSNews
//
//  Created by Kris on 6/6/2566 BE.
//

import SwiftUI

struct BookmarkTab: View {
    @EnvironmentObject var vm: ArticleBookmarkViewModel
    
    var body: some View {
        ArticleList(articles: vm.articles)
            .overlay {
                overlay(isEmpty: vm.articles.isEmpty)
            }
            .searchable(text: $vm.searchText)
            .navigationTitle("Saved Articles")
    }
    
    @ViewBuilder
    func overlay(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholder(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTab_Previews: PreviewProvider {
    
    @StateObject static var vm = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        BookmarkTab()
            .environmentObject(vm)
    }
}
