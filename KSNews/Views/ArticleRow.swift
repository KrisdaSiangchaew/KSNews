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

struct ArticleRow: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let article: Article
    
    @State private var showSheet = false
    
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            GeometryReader { contentView(proxy: $0) }
        default:
            contentView()
        }
    }
    
    @ViewBuilder
    private func contentView(proxy: GeometryProxy? = nil) -> some View {
        // Hero image
        VStack(alignment: .center, spacing: 16) {
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure(_):
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .asyncImageFrame(horizontalSizeClass: horizontalSizeClass ?? .compact)
            .background(Color.gray.opacity(0.2))
            .clipped()
            
        // Title and Description
            VStack(alignment: .leading, spacing: 8) {
                Text(article.titleText)
                    .font(.headline)
                    .lineLimit(3)
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
            }
            .padding([.horizontal])
            .onTapGesture {
                showSheet = true
            }
            
            if horizontalSizeClass == .regular {
                Spacer()
            }
            
        // Footnote and buttons
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
            .padding([.horizontal, .bottom])
        }
        .sheet(isPresented: $showSheet) {
            SafariView(url: article.articleURL)
        }
    }
}


fileprivate extension View {
    @ViewBuilder
    func asyncImageFrame(horizontalSizeClass: UserInterfaceSizeClass) -> some View {
        switch horizontalSizeClass {
        case .regular:
            frame(minHeight: 180)
        default:
            frame(minHeight: 200, maxHeight: 300)
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
