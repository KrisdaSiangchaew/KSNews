//
//  CategoryLabel.swift
//  KSNews
//
//  Created by Kris on 13/6/2566 BE.
//

import SwiftUI

struct CategoryLabel: View {
    let category: Category
    
    var body: some View {
        Label(category.text.capitalized, systemImage: category.systemImage)
    }
}

struct CategoryLabel_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLabel(category: .business)
    }
}
