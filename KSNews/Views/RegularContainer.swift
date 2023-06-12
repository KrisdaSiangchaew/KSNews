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
                .navigationDestination(for: Category.self) { category in
                    Text(category.text)
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
