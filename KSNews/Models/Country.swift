//
//  Country.swift
//  KSNews
//
//  Created by Kris on 5/6/2566 BE.
//

import Foundation

enum Country: String, CaseIterable {
    case us
    case de
    case jp
    case th
    case sg
    case ph
}

extension Country {
    var flag: String { "flag" }
    
    var text: String {
        switch self {
        case .jp: return "🇯🇵 Japan"
        case .de: return "🇩🇪 Germany"
        case .us: return "🇺🇸 United States"
        case .th: return "🇹🇭 Thailand"
        case .sg: return "🇸🇬 Singapore"
        case .ph: return "🇵🇭 Philippines"
        }
    }
}

extension Country: Identifiable {
    var id: Self { self }
}

extension Country {
    static var menuItems: [MenuItem] {
        allCases.map { .country($0) }
    }
}
