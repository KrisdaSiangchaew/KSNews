//
//  NewsAPI.swift
//  KSNews
//
//  Created by Kris on 4/6/2566 BE.
//

import Foundation

// https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=078f31481d034f20a8180d0e20d8f0ee

struct NewsAPI {
    static let shared = NewsAPI()
    
    private init() { }
    let baseURLString = "https://newsapi.org/v2/top-headlines?"
    let searchURLString = "https://newsapi.org/v2/everything?"
    let session = URLSession.shared
    let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601
    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    
    private func fetchArticles(from urlString: String) async throws -> [Article] {
//        #warning("remove below directive")
//        #if targetEnvironment(simulator)
//        return Article.previewData
//        #endif
        let newsAPIResponse: NewsAPIResponse = try await URLSession.shared.decode(dateDecodingStrategy: dateDecodingStrategy, from: urlString)
        return newsAPIResponse.articles ?? []
    }
    
    func search(for query: String) async throws -> [Article] {
        try await fetchArticles(from: generateSearchURLString(from: query))
    }
    
    func fetch(from category: Category, in country: Country) async throws -> [Article] {
        try await fetchArticles(from: generateNewsURLString(from: category, in: country))
        
    }
    
    private var apiKey: String {
        let resourceName = "NewsAPI-Info"
        let resourceType = "plist"
        let keyName = "API_KEY"
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: resourceType) else {
            fatalError("Couldn't find file '\(resourceName).\(resourceType)'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: keyName) as? String else {
            fatalError("Couldn't find key '\(keyName)' in '\(resourceName).\(resourceType)'.")
        }
        return value
    }
    
    private func generateSearchURLString(from query: String) -> String {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var urlString = searchURLString
        urlString += "apiKey=\(apiKey)"
        urlString += "&language=en"
        urlString += "&q=\(percentEncodedString)"
        return urlString
    }
    
    private func generateNewsURLString(from category: Category, in country: Country = .us) -> String {
        var urlString = baseURLString
        urlString += "country=\(country.rawValue)"
        urlString += "&category=\(category.rawValue)"
        urlString += "&apiKey=\(apiKey)"
        return urlString
    }
}
