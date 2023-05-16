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
   fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject{
    @Published private(set) var people: [Prospect]
    let saveKey = "saveData"
    
    init(){
        if let data = UserDefaults.standard.data(forKey: saveKey){
            if let decode = try? JSONDecoder().decode([Prospect].self, from: data){
                people = decode
                return
            }
        }
        people = []
    }
    
    
    func add(_ prospect: Prospect){
        people.append(prospect)
        save()
    }
    func remove(_ prospect: Prospect) {
            if let index = people.firstIndex(where: { $0.id == prospect.id }) {
                people.remove(at: index)
                save()
            }
        }
    
   private func save(){
        if let encoded = try? JSONEncoder().encode(people){
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func toggle(_ prospect: Prospect){
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
}
