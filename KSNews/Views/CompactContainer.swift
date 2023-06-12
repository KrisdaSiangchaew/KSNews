//
//  TabsContainer.swift
//  KSNews
//
//  Created by Krisda Siangchaew on 12/6/23.
//

import SwiftUI

struct CompactContainer: View {
    @State private var selectedTab: Tab = .news
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NewsTab()
                .tag(Tab.news)
                .tabItem {
                    NewsLabel()
                }
            SearchTab()
                .tag(Tab.search)
                .tabItem {
                    SearchLabel()
                }
            BookmarkTab()
                .tag(Tab.bookmark)
                .tabItem {
                    SavedLabel()
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
