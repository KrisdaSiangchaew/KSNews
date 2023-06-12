//
//  ContentView.swift
//  KSNews
//
//  Created by Kris on 2/6/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            RegularContainer()
        default:
            CompactContainer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var vm = ArticleBookmarkViewModel.shared
    static var previews: some View {
        ContentView()
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
