//
//  SearchLabel.swift
//  KSNews
//
//  Created by Kris on 12/6/2566 BE.
//

import SwiftUI

struct SearchLabel: View {
    var body: some View {
        Label(Tab.search.text.capitalized, systemImage: "magnifyingglass")    }
}

struct SearchLabel_Previews: PreviewProvider {
    static var previews: some View {
        SearchLabel()
    }
}
