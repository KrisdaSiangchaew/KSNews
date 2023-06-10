//
//  URLSession-Decode.swift
//  KSNews
//
//  Created by Kris on 4/6/2566 BE.
//

import Foundation

enum URLSessionError: Error, LocalizedError {
    case invalidURL
    case dataTaskError(String)
    case invalidResponseStatus(String)
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The endpoint URL is invalid.", comment: "")
        case .dataTaskError(let string):
            return string
        case .invalidResponseStatus(let message):
            return NSLocalizedString("The API failed to provide valid response. \n Message: \(message)", comment: "")
        case .decodingError(let string):
            return string
        }
    }
}

extension URLSession {
    func decode<T: Decodable>(_ type: T.Type = T.self, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys, from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLSessionError.invalidURL
        }
        let (data, response) = try await data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            do {
                let message = try JSONDecoder().decode(NewsAPIResponse.self, from: data).message ?? "unknown"
                throw URLSessionError.invalidResponseStatus(message)
            } catch {
                throw URLSessionError.decodingError(error.localizedDescription)
            }
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw URLSessionError.decodingError(error.localizedDescription)
        }
    }
}
