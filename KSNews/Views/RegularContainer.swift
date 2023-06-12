//
//  SplitContainer.swift
//  KSNews
//
//  Created by Krisda Siangchaew on 12/6/23.
//

import SwiftUI

struct RegularContainer: View {
    @State private var categorySelection: Category = .general
    var body: some View {
        NavigationSplitView {
            Sidebar()
                .navigationDestination(for: Tab.self) { tab in
                    switch tab {
                    case .search: SearchTab()
                    case .bookmark: BookmarkTab()
                    default: NewsTab()
                    }
                }
                .navigationDestination(for: Category.self) {
                    // do query
                    Text($0.text)
                }
                .navigationDestination(for: Country.self) {
                    // do query
                    Text($0.text)
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
