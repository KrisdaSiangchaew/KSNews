//
//  SavedLabel.swift
//  KSNews
//
//  Created by Kris on 12/6/2566 BE.
//

import SwiftUI

struct SavedLabel: View {
    var body: some View {
        Label(Tab.bookmark.text.capitalized, systemImage: "bookmark")    }
}

struct SavedLabel_Previews: PreviewProvider {
    static var previews: some View {
        SavedLabel()
    }
}
