//
//  ContentView.swift
//  LittleLemon
//
//  Created by Leland Bove on 2/22/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    /*
     @FetchRequest(
     sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
     animation: .default)
     private var items: FetchedResults<Item>
     */
    
    var body: some View {
        Onboarding()
    }
}
    
    
#Preview {
    ContentView()
}
    
