//
//  DataFetchPhase.swift
//  KSNews
//
//  Created by Kris on 7/6/2566 BE.
//

import Foundation

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}
