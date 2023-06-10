//
//  ArticleRow.swift
//  KSNews
//
//  Created by Kris on 3/6/2566 BE.
//

import SwiftUI

struct BookmarkButton: View {
    @EnvironmentObject var vm: ArticleBookmarkViewModel
    
    let article: Article
    
    var body: some View {
        Button {
            toggleBookmark()
        } label: {
            Image(systemName: vm.isBookmarked(article: article) ? "bookmark.fill" : "bookmark")
        }
        .buttonStyle(.bordered)
        .clipShape(Circle())
    }
    
    func toggleBookmark() {
        if vm.isBookmarked(article: article) {
            vm.removeFromBookmark(article: article)
        } else {
            vm.addToBookmark(article: article)
        }
    }
}

struct ShareButton: View {
    let article: Article
    
    var body: some View {
        ShareLink(item: article.articleURL) {
            Image(systemName: "square.and.arrow.up")
        }
        .padding(.init(8))
        .foregroundColor(Color.accentColor)
        .background(Color.secondary.opacity(0.2))
        .clipShape(Circle())
    }
}

struct ArticleFooter: View {
    let article: Article
    
    var body: some View {
        HStack {
            Text(article.captionText)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .allowsHitTesting(false)
            
            Spacer()
            
            BookmarkButton(article: article)

            ShareButton(article: article)
        }
    }
}

struct ArticleText: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.titleText)
                .font(.headline)
                .lineLimit(3)
            Text(article.descriptionText)
                .font(.subheadline)
                .lineLimit(2)
        }
    }
}

struct ArticleHero: View {
    let article: Article
    
    var body: some View {
        AsyncImage(url: article.imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            HStack {
                Spacer()
                Image(systemName: "photo")
                    .imageScale(.large)
                    .frame(minHeight: 200)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.gray.opacity(0.2))
        .clipped()
    }
}

struct ArticleRow: View {
    let article: Article
    
    @State private var showSheet = false
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center, spacing: 16) {
                ArticleHero(article: article)
                ArticleText(article: article)
                    .padding([.horizontal])
            }
            .onTapGesture {
                showSheet = true
            }
            ArticleFooter(article: article)
                .padding([.horizontal, .bottom])
        }
        
        .sheet(isPresented: $showSheet) {
            SafariView(url: article.articleURL)
        }
    }
}

struct ArticleRow_Previews: PreviewProvider {
    @StateObject static var vm = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        ArticleRow(article: Article.previewData[5])
            .environmentObject(vm)
            .previewLayout(.sizeThatFits)
    }
}
