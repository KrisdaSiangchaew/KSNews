//
//  ArticleNewsViewModel.swift
//  KSNews
//
//  Created by Kris on 5/6/2566 BE.
//

import Foundation

@MainActor
class ArticleNewsViewModel: ObservableObject {
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var selectedCategory: Category = .general
    @Published var selectedCountry: Country = .us
    
    let country: Country
    let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general, country: Country = .us) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
        self.country = country
    }
    
    func loadArticles() async {
        do {
            let articles = try await newsAPI.fetch(from: selectedCategory, in: selectedCountry)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
}
