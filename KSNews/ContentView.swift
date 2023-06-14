//
//  ContentView.swift
//  KSNews
//
//  Created by Kris on 2/6/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            SidebarContentView()
        default:
            TabContentView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var vm = ArticleBookmarkViewModel.shared
    static var previews: some View {
        ContentView()
            .environmentObject(vm)
    }
}
