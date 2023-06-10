//
//  Retry.swift
//  KSNews
//
//  Created by Kris on 5/6/2566 BE.
//

import SwiftUI

struct Retry: View {
    let text: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            Button(action: retryAction) {
                Text("Try Again")
            }
        }
    }
}

struct Retry_Previews: PreviewProvider {
    static var previews: some View {
        Retry(text: "Some went wrong") {
            
        }
    }
}
