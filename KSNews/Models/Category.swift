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
        if self == .general { return "Top Headlines"} else { return self.rawValue }
    }
}
