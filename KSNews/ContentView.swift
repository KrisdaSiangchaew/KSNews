//
//  ContentView.swift
//  KSNews
//
//  Created by Kris on 2/6/2566 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTab()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            SearchTab()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            BookmarkTab()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var vm = ArticleBookmarkViewModel.shared
    static var previews: some View {
        ContentView()
            .environmentObject(vm)
    }
}
