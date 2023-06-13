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
            linkToSearch
            linkToSaved
            .listRowSeparator(.hidden)
            
            Section {
                linkToCategory
            } header: {
                Text("Category")
            }
            
            Section {
                linkToCountry
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
