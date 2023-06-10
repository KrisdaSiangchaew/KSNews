//
//  Article.swift
//  KSNews
//
//  Created by Kris on 2/6/2566 BE.
//

import Foundation

fileprivate var relativeDateFormatter = RelativeDateTimeFormatter()

struct Article {
    let source: Source
    let url: String
    let publishedAt: Date
    
    let title: String?
    let author: String?
    let description: String?
    let urlToImage: String?
    
    var titleText: String {
        title ?? ""
    }
    
    var authorText: String {
        author ?? ""
    }
    
    var captionText: String {
        "\(source.name) · \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: .now))"
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension Article: Codable { }
extension Article: Equatable { }
extension Article: Identifiable {
    var id: String { url }
}
extension Article: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
        hasher.combine(publishedAt)
    }
}

extension Article {
    static var previewData: [Article] {
        let response: NewsAPIResponse = Bundle.main.decode(NewsAPIResponse.self, from: "news.json", dateDecodingStrategy: .iso8601)
        return response.articles ?? []
    }
}

struct Source {
    let name: String
}

extension Source: Codable { }
extension Source: Equatable { }

