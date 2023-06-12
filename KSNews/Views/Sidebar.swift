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
            navLink(for: .search)
            navLink(for: .bookmark)
                .listRowSeparator(.hidden)
            Section {
                ForEach(Category.allCases) { category in
                    navLink(for: category)
                }
            } header: {
                Text("Category")
            }
            Section {
                ForEach(Country.allCases) { country in
                    navLink(for: country)
                }
            } header: {
                Text("Country")
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("KSNews")
    }
    
    @ViewBuilder
    func navLink(for tab: Tab) -> some View {
        switch tab {
        case .news:
            NavigationLink(value: tab) {
                NewsLabel()
            }
        case .search:
            NavigationLink(value: tab) {
                SearchLabel()
            }
        case .bookmark:
            NavigationLink(value: tab) {
                SavedLabel()
            }
        }
    }
    
    @ViewBuilder
    func navLink(for category: Category) -> some View {
        NavigationLink(value: category) {
            CategoryLabel(category: category)            
        }
    }
    
    @ViewBuilder
    func navLink(for country: Country) -> some View {
        NavigationLink(value: country) {
            CountryLabel(country: country)
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
