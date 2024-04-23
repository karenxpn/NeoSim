//
//  CountryPicker.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 23.04.24.
//

import SwiftUI

struct CountryPicker: View {

    @Binding var selection: PhoneModel
    @State private var searchText = ""

    var body: some View {
        
        NavigationStack {
            List {
                ForEach(searchResult, id: \.id) { country in
                    Button {
                        selection = country
                    } label: {
                        HStack {
                            TextHelper(text: country.flag, fontSize: 20)
                            TextHelper(text: country.name, fontSize: 16)
                            Spacer()
                            TextHelper(text: country.dial_code, fontSize: 16)
                            
                            if selection.id == country.id {
                                Image(systemName: "checkmark")
                            }
                        }
                    }.buttonStyle(.borderless)
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        }
    }
    
    var searchResult: [PhoneModel] {
        if searchText.isEmpty {
            return PhoneModel.allCountry
        } else {
            return PhoneModel.allCountry.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
