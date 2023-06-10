//
//  ArticleList.swift
//  KSNews
//
//  Created by Kris on 4/6/2566 BE.
//

import SwiftUI

struct ArticleList: View {
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        List(articles, id: \.self, selection: $selectedArticle) { article in
            ArticleRow(article: article)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL)
        }
    }
}

struct ArticleList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ArticleList(articles: Article.previewData)
                .environmentObject(ArticleBookmarkViewModel.shared)
        }
    }
}
