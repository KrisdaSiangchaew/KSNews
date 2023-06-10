//
//  EmptyPlaceholder.swift
//  KSNews
//
//  Created by Kris on 5/6/2566 BE.
//

import SwiftUI

struct EmptyPlaceholder: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50)

            }
            Text(text)
            Spacer()
        }
    }
}

struct EmptyPlaceholder_Previews: PreviewProvider {
    static var previews: EmptyPlaceholder {
        EmptyPlaceholder(text: "No saved articles", image: Image(systemName: "bookmark"))
    }
}
