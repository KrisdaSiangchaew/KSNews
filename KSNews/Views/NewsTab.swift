//
//  NewsTab.swift
//  KSNews
//
//  Created by Kris on 5/6/2566 BE.
//

import SwiftUI

struct NewsTab: View {
    @StateObject var vm = ArticleNewsViewModel()
    
    var body: some View {
        ArticleList(articles: articles)
            .overlay(overlayView)
            .task(id: vm.selectedCountry) { await loadTask() }
            .task(id: vm.selectedCategory) { await loadTask() }
            .refreshable {
                Task {
                    await loadTask()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    countryMenu
                    categoryMenu
                }
            }
            .navigationTitle(vm.selectedCategory.text.capitalized)
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
            Picker("Menu", selection: $vm.selectedCategory) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal")
        }
    }
    
    private var countryMenu: some View {
        Menu {
            Picker("Country", selection: $vm.selectedCountry) {
                ForEach(Country.allCases) {
                    Text("\($0.text)").tag($0)
                }
            }
        } label: {
            Image(systemName: vm.selectedCountry.flag)
        }
    }
}

struct NewsTab_Previews: PreviewProvider {
    static var previews: some View {
        NewsTab(vm: ArticleNewsViewModel(articles: Article.previewData))
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
