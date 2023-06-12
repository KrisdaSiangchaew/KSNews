//
//  CountryList.swift
//  KSNews
//
//  Created by Kris on 12/6/2566 BE.
//

import SwiftUI

struct CountryList: View {
    @ObservedObject var model: ArticleNewsViewModel
    
    var body: some View {
        Picker("Country", selection: $model.selectedCountry) {
            ForEach(Country.allCases) { country in
                Text("\(country.flag) \(country.text)").tag(country)
            }
        }
    }
}

struct CountryList_Previews: PreviewProvider {
    @StateObject static var vm = ArticleNewsViewModel()
    
    static var previews: some View {
        CountryList(model: vm)
    }
}
