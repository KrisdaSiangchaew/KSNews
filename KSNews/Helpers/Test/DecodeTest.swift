//
//  DecodeTest.swift
//  KSNews
//
//  Created by Kris on 3/6/2566 BE.
//

import SwiftUI

struct DecodeTest: View {
    @State private var articles: [Article] = Article.previewData
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: articles[0].imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 100)
            } placeholder: {
                Image(systemName: "photo")
                    .font(.largeTitle)
            }

            Text(articles[0].titleText)
        }
    }
}

struct DecodeTest_Previews: PreviewProvider {
    static var previews: some View {
        DecodeTest()
    }
}
