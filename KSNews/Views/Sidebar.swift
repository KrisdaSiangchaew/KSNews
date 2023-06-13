//
//  Sidebar.swift
//  KSNews
//
//  Created by Krisda Siangchaew on 12/6/23.
//

import SwiftUI

struct Sidebar: View {
    @ObservedObject var model = ArticleNewsViewModel.shared
    
    var body: some View {
        List {
            NavigationLink(value: Tab.search) {
                SearchLabel()
            }
            NavigationLink(value: Tab.bookmark) {
                SavedLabel()
            }
            .listRowSeparator(.hidden)
            
            Section {
                sidebarCategoryLinks
            } header: {
                Text("Category")
            }
            
            Section {
                sidebarCountryLinks
            } header: {
                Text("Country")
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("KSNews")
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
