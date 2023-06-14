//
//  SidebarContentView.swift
//  KSNews
//
//  Created by Kris on 13/6/2566 BE.
//

import SwiftUI

struct SidebarContentView: View {
    @State private var selectedItem: MenuItem.ID?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedItem) {
                ForEach([MenuItem.saved, MenuItem.search]) {
                    navigationLinkForMenuItem($0)
                }
                
                Section {
                    ForEach(Category.menuItems) {
                        navigationLinkForMenuItem($0)
                    }
                } header: {
                    Text("Categories")
                }
                
                Section {
                    ForEach(Country.menuItems) {
                        navigationLinkForMenuItem($0)
                    }
                } header: {
                    Text("Countries")
                }
            }
            .navigationTitle("KS News")
            .listStyle(.sidebar)
        } detail: {
            NewsTab()
        }
    }
    
    private func navigationLinkForMenuItem(_ item: MenuItem) -> some View {
        NavigationLink {
            viewForMenuItem(item)
        } label: {
            Label(item.text, systemImage: item.systemImage)
        }

    }
    
    @ViewBuilder
    private func viewForMenuItem(_ item: MenuItem) -> some View {
        switch item {
        case .search:
            SearchTab()
        case .saved:
            BookmarkTab()
        case .category(let category):
            NewsTab(cateogry: category)
        case .country(let country):
            NewsTab(country: country)
        }
    }
}

struct SidebarContentView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarContentView()
    }
}
