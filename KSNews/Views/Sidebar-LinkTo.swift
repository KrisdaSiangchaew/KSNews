//
//  ButtonLinkCategory.swift
//  KSNews
//
//  Created by Krisda Siangchaew on 13/6/23.
//

import SwiftUI

extension Sidebar {
    var linkToSearch: some View {
        NavigationLink(value: Tab.search) {
            SearchLabel()
        }
    }
    
    var linkToSaved: some View {
        NavigationLink(value: Tab.bookmark) {
            SavedLabel()
        }
    }
    
    var linkToCategory: some View {
        ForEach(Category.allCases) { category in
            Button {
                model.selectedCategory = category
            } label: {
                NavigationLink(value: category) {
                    CategoryLabel(category: category)
                }
            }
        }
    }
    
    var linkToCountry: some View {
        ForEach(Country.allCases) { country in
            Button {
                model.selectedCountry = country
            } label: {
                NavigationLink(value: country) {
                    CountryLabel(country: country)
                }
            }
        }
    }
}
