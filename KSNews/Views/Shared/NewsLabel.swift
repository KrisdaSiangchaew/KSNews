//
//  NewsLabel.swift
//  KSNews
//
//  Created by Kris on 12/6/2566 BE.
//

import SwiftUI

struct NewsLabel: View {
    var body: some View {
        Label(Tab.news.text.capitalized, systemImage: "newspaper")    }
}

struct NewsLabel_Previews: PreviewProvider {
    static var previews: some View {
        NewsLabel()
    }
}
