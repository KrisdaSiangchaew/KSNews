//
//  Sidebar.swift
//  KSNews
//
//  Created by Krisda Siangchaew on 12/6/23.
//

import SwiftUI

struct Sidebar: View {
    @State private var selection: Category?
    
    var body: some View {
        List(Category.allCases, selection: $selection) { category in
            NavigationLink(category.text.capitalized, value: category)
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Sidebar()
        }
    }
}
