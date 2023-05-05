//
//  Prospect.swift
//  HotProspects
//
//  Created by Tamim Khan on 5/5/23.
//

import SwiftUI

class Prospect: Identifiable, Codable{
    var id = UUID()
    var name = "Anoymous"
    var emailAddress = ""
    var isContacted = false
}

@MainActor class Prospects: ObservableObject{
    @Published var people: [Prospect]
    
    init(){
        self.people = []
    }
}