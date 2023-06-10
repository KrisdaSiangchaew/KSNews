//
//  ArticleSearchViewModel.swift
//  KSNews
//
//  Created by Kris on 7/6/2566 BE.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery: String = ""
    @Published var history: [String] = []
    
    private let historyStore = PlistDataStore<[String]>(filename: "history")
    
    
    static let shared = ArticleSearchViewModel()
    
    let maxSearchHistory = 10
    
    private init() {
        Task {
            await load()
        }
    }
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        do {
            let articles = try await NewsAPI.shared.search(for: searchQuery)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
    
    func saveToHistory(_ text: String) {
        if history.count == maxSearchHistory {
            history.remove(at: maxSearchHistory - 1)
        }
        if let index = history.firstIndex(where: { $0 == text }) {
            history.remove(at: index)
        }
        history.insert(text, at: 0)
        historyUpdated()
    }
    
    func removeFromHistory(_ text: String) {
        if let index = history.firstIndex(where: { $0 == text }) {
            history.remove(at: index)
        }
        historyUpdated()
    }
    
    func clearHistory() {
        history = []
        historyUpdated()
    }
    
    private func load() async {
        await self.history = historyStore.load() ?? []
    }
    
    private func historyUpdated() {
        let history = self.history
        Task {
            await historyStore.save(history)
        }
    }
}
