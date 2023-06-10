//
//  ArticleBookmarkViewModel.swift
//  KSNews
//
//  Created by Kris on 5/6/2566 BE.
//

import Foundation

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    @Published var bookmarks: [Article] = []
    private let bookmarkStore = PlistDataStore<[Article]>(filename: "bookmark")
    static let shared = ArticleBookmarkViewModel()
    
    @Published var searchText: String = ""
    
    var articles: [Article] {
        if searchText.isEmpty {
            return bookmarks
        }
        return bookmarks.filter { article in
            for string in [article.titleText, article.descriptionText] {
                if string.localizedCaseInsensitiveContains(searchText) { return true }
            }
            
            return false
        }
    }
    
    private init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
        self.bookmarks = await bookmarkStore.load() ?? []
    }
    
    func isBookmarked(article: Article) -> Bool {
        bookmarks.first { $0.id == article.id } != nil
    }
    
    func addToBookmark(article: Article) {
        guard !isBookmarked(article: article) else { return }
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeFromBookmark(article: Article) {
        guard let index = bookmarks.firstIndex(where: { bookmark in
            bookmark.id == article.id
        }) else { return }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        Task {
            await bookmarkStore.save(bookmarks)
        }
    }
}
