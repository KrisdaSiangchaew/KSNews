//
//  ArticleList.swift
//  KSNews
//
//  Created by Kris on 4/6/2566 BE.
//

import SwiftUI

struct ArticleList: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        rootView
    }
    
    private var listView: some View {
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
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 8)]) {
                ForEach(articles) { article in
                    ArticleRow(article: article)
                        .frame(height: 390)
                        .background(Color(uiColor: .systemBackground))
                        .mask(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 4)
                        .padding(.bottom, 4)
                }
            }
            .padding()
        }
        .background(Color(uiColor: .secondarySystemGroupedBackground))
    }
    
    @ViewBuilder
    private var rootView: some View {
        switch horizontalSizeClass {
        case .regular: gridView
        default: listView
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
