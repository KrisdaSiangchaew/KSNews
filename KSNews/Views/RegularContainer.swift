//
//  SplitContainer.swift
//  KSNews
//
//  Created by Krisda Siangchaew on 12/6/23.
//

import SwiftUI

struct RegularContainer: View {
    @ObservedObject var articleNewsModel = ArticleNewsViewModel.shared
    
    var body: some View {
        NavigationSplitView {
            Sidebar()
                .navigationDestination(for: Tab.self) { tab in
                    switch tab {
                    case .bookmark: BookmarkTab()
                    default: SearchTab()
                    }
                }
                .navigationDestination(for: Category.self) { _ in
                    NewsTab()
                }
                .navigationDestination(for: Country.self) { _ in
                    NewsTab()
                }
        } detail: {
            NewsTab()
        }
    }
    
    private var sidebar: some View {
        Text("Hello")
            .navigationTitle("KSNews")
    }
}

struct RegularContainer_Previews: PreviewProvider {
    static var previews: some View {
        RegularContainer()
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
