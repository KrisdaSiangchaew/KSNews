//
//  Tab.swift
//  KSNews
//
//  Created by Kris on 12/6/2566 BE.
//

import Foundation

enum Tab: String, CaseIterable {
    case bookmark
    case news
    case search
}

extension Tab: Identifiable {
    public var id: Self { self }
}

extension Tab {
    var text: String {
        switch self {
        case .bookmark:
            return "saved"
        case .news:
            return "news"
        case .search:
            return "search"
        }
    }
}

extension Tab {
    var systemImage: String {
        switch self {
        case .bookmark:
            return "bookmark"
        case .news:
            return "newspaper"
        case .search:
            return "magnifyingglass"
        }
    }
}

extension Tab: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}

extension Tab: Codable { }
