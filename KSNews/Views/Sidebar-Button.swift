//
//  ButtonLinkCategory.swift
//  KSNews
//
//  Created by Krisda Siangchaew on 13/6/23.
//

import SwiftUI

extension Sidebar {
    var sidebarCategoryLinks: some View {
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
    
    var sidebarCountryLinks: some View {
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
