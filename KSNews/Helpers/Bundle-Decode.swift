//
//  Bundle-Decode.swift
//  IOSConcurrency
//
//  Created by Krisda Siangchaew on 2/6/23.
//

import Foundation

extension Bundle {
    public func decode<T: Decodable>(_ type: T.Type = T.self,
                                     from file: String,
                                     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return decodedData
    }
}
