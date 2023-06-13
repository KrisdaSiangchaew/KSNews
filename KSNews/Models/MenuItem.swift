//
//  MenuItem.swift
//  KSNews
//
//  Created by Kris on 13/6/2566 BE.
//

import Foundation

enum MenuItem: CaseIterable {
    case search
    case saved
    case category(Category)
    case country(Country)
    
    var text: String {
        switch self {
        case .search:
            return "Search"
        case .saved:
            return "Saved"
        case .category(let category):
            return category.text
        case .country(let country):
            return country.text
        }
    }
    
    var systemImage: String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .saved:
            return "bookmark"
        case .category(let category):
            return category.systemImage
        case .country(let country):
            return country.flag
        }
    }
    
    static var allCases: [MenuItem] {
        return [.search, .saved] + Category.menuItems + Country.menuItems
    }
}

extension MenuItem: Identifiable {
    var id: String {
        switch self {
        case .saved: return "saved"
        case .search: return "search"
        case .category(let category): return category.rawValue
        case .country(let country): return country.rawValue
        }
    }
}
