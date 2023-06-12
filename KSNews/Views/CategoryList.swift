//
//  CategoryList.swift
//  KSNews
//
//  Created by Kris on 12/6/2566 BE.
//

import SwiftUI

struct CategoryList: View {
    @ObservedObject var model: ArticleNewsViewModel
    
    var body: some View {
        Picker("Menu", selection: $model.selectedCategory) {
            ForEach(Category.allCases) {
                Label($0.text.capitalized, systemImage: $0.systemImage).tag($0)
            }
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    @StateObject static var vm = ArticleNewsViewModel()
    
    static var previews: some View {
        CategoryList(model: vm)
    }
}
