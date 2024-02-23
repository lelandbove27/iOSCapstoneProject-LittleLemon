//
//  Menu.swift
//  LittleLemon
//
//  Created by Leland Bove on 2/22/24.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            
            List {
                
            }
        }
        .onAppear() {
            getMenuData()
        }
    }
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let urlObject = URL(string: urlString)!
        let urlRequest = URLRequest(url: urlObject)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            if let menuData = data {
                let decoder = JSONDecoder()
                let menuItems = try? decoder.decode(MenuList.self, from: menuData)
            }
        }
        task.resume()
        
    }
}

#Preview {
    Menu()
}
