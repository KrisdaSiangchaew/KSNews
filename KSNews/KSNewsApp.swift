//
//  KSNewsApp.swift
//  KSNews
//
//  Created by Kris on 2/6/2566 BE.
//

import SwiftUI

@main
struct KSNewsApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
