//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tamim Khan on 5/5/23.
//
import NotificationCenter
import CodeScanner
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
    @State private var showingDeleteAlert = false
    
    
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
    
    @State private var isShowingScanner = false
    
    
    
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
                    .swipeActions {
                        
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button{
                                addNotification(for: prospect)
                            }label: {
                                Label("Remind me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                    .swipeActions(edge: .leading){
                        Button {
                                prospects.remove(prospect)
                            } label: {
                                Label("Remove", systemImage: "trash")
                            }
                            .tint(.red)
                    }
                
                    
                }
               
            }
                .navigationTitle(title)
                .toolbar{
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                           isShowingScanner = true
                        }label: {
                            Label("Scan", systemImage: "qrcode.viewfinder")
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner){
                    CodeScannerView(codeTypes: [.qr], simulatedData: "tamim\ntamim@swift.com", completion: handleScan)
                }
        }
        
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Did not Accepted")
                    }
                }
            }
        }
    }
    
    
    func handleScan(result: Result<ScanResult, ScanError>){
        isShowingScanner = false
        switch result{
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else {return}
            
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            
            prospects.add(person)
            
        case .failure(let error):
            print("Scannin failed \(error.localizedDescription)")
        }
        
    }
}



struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
