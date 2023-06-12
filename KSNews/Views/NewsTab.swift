//
//  NewsTab.swift
//  KSNews
//
//  Created by Kris on 5/6/2566 BE.
//

import SwiftUI

struct NewsTab: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @StateObject var vm = ArticleNewsViewModel()
    
    var showToolbar: Bool {
        switch horizontalSizeClass {
        case .compact:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
        NavigationStack {
            ArticleList(articles: articles)
                .overlay(overlayView)
                .task(id: vm.selectedCountry) {
                    await loadTask()
                }
                .task(id: vm.selectedCategory) {
                    await loadTask()
                }
                .refreshable {
                    Task {
                        await loadTask()
                    }
                }
                .toolbar {
                    if showToolbar {
                        ToolbarItemGroup(placement: .automatic) {
                            countryMenu
                            categoryMenu
                        }
                    }
                }
                .navigationTitle(vm.selectedCategory.text.capitalized)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch vm.phase {
        case .empty: ProgressView()
        case .success(let articles) where articles.isEmpty: EmptyPlaceholder(text: "No articles", image: nil)
        case .failure(let error): Retry(text: error.localizedDescription) {
            Task {
                await loadTask()
            }
        }
        default: EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case .success(let fetchedData) = vm.phase {
            return fetchedData
        } else {
            return []
        }
    }
    
    private func loadTask() async {
        await vm.loadArticles()
    }
    
    private var categoryMenu: some View {
        Menu {
            CategoryList(model: vm)
        } label: {
            Image(systemName: "line.3.horizontal")
        }
    }
    
    private var countryMenu: some View {
        Menu {
            CountryList(model: vm)
        } label: {
            Text(vm.selectedCountry.flag)
        }
    }
}

struct NewsTab_Previews: PreviewProvider {
    static var previews: some View {
        NewsTab(vm: ArticleNewsViewModel(articles: Article.previewData))
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
