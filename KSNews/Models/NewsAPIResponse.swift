//
//  NewsAPIResponse.swift
//  KSNews
//
//  Created by Kris on 3/6/2566 BE.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    
    let totalResults: Int?
    let articles: [Article]?
    let code: String?
    let message: String?
}
