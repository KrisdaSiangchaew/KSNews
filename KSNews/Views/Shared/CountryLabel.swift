//
//  CountryLabel.swift
//  KSNews
//
//  Created by Kris on 13/6/2566 BE.
//

import SwiftUI

struct CountryLabel: View {
    let country: Country
    
    var body: some View {
        Text("\(country.text) \(country.flag)").tag(country)
    }
}

struct CountryLabel_Previews: PreviewProvider {
    static var previews: some View {
        CountryLabel(country: .th)
    }
}
