//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tamim Khan on 5/5/23.
//

import SwiftUI

struct ProspectsView: View {
    
    enum FilterType{
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var title: String{
        switch filter{
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "uncontacted people"
        }
    }
    
    
    @EnvironmentObject var prospects: Prospects
    
    
    var filterProspects: [Prospect]{
        switch filter{
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter{ $0.isContacted }
        case .uncontacted:
            return prospects.people.filter{ !$0.isContacted }
        }
    }
    
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(filterProspects){ prospect in
                    VStack(alignment: .leading){
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
                .navigationTitle(title)
                .toolbar{
                    Button{
                        let prospect = Prospect()
                        prospect.name = "Tamim"
                        prospect.emailAddress = "tamim@swift.com"
                        prospects.people.append(prospect)
                    }label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
        }
        
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
