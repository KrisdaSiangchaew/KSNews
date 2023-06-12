//
//  TabsContainer.swift
//  KSNews
//
//  Created by Krisda Siangchaew on 12/6/23.
//

import SwiftUI

struct CompactContainer: View {
    enum TabTag {
        case news, search, bookmark
    }
    @State private var selectedTab: TabTag = .news
    var body: some View {
        TabView(selection: $selectedTab) {
            NewsTab()
                .tag(TabTag.news)
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            SearchTab()
                .tag(TabTag.search)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            BookmarkTab()
                .tag(TabTag.bookmark)
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

struct CompactContainer_Previews: PreviewProvider {
    static var previews: some View {
        CompactContainer()
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
