//
//  TabContentView.swift
//  KSNews
//
//  Created by Kris on 13/6/2566 BE.
//

import SwiftUI

struct TabContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                NewsTab()
            }
            .tabItem {
                Label("News", systemImage: "newspaper")
            }
            
            NavigationStack {
                SearchTab()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            NavigationStack {
                BookmarkTab()
            }
            .tabItem {
                Label("Saved", systemImage: "bookmark")
            }
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView()
    }
}
