//
//  Category.swift
//  KSNews
//
//  Created by Kris on 4/6/2566 BE.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
}

extension Category: Identifiable {
    public var id: Self { self }
}

extension Category {
    var text: String {
        if self == .general { return "Top Headlines"} else { return self.rawValue.capitalized }
    }
}

extension Category {
    var systemImage: String {
        switch self {
        case .general:
            return "newspaper"
        case .business:
            return "building.2"
        case .technology:
            return "desktopcomputer"
        case .entertainment:
            return "tv"
        case .sports:
            return "sportscourt"
        case .science:
            return "wave.3.right"
        case .health:
            return "cross"
        }
    }
}

extension Category {
    static var menuItems: [MenuItem] {
        Category.allCases.map { MenuItem.category($0) }
    }
}
