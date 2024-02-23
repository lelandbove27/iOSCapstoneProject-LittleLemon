//
//  Menu.swift
//  LittleLemon
//
//  Created by Leland Bove on 2/22/24.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var isDataFetched = false
    @State var searchText = ""
    @State var category = Category.none
    
    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 300, height: 50)
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(30)
                    .padding(.trailing, 10)
            }
            
            VStack {
                HStack {
                    VStack {
                        Text("Little Lemon")
                            .font(.largeTitle)
                        Text("Chicago")
                            .font(.title2)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    }
                    Image("hero-image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                TextField("Search Menu", text: $searchText)
                    .background(Color.white)
                    .padding(5)
            }
            .background(Color(hex: "495E57"))
            
            ScrollView(.horizontal) {
                HStack {
                    Button("Starters") {
                        if category != Category.Starters {
                            category = Category.Starters
                        } else {
                            category = Category.none
                        }
                    }
                    .frame(width: 100, height: 30)
                    .background((category == Category.Starters) ? Color(hex: "495E57") : Color(hex: "F4CE14"))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    
                    
                    Button("Mains") {
                        if category != Category.Mains {
                            category = Category.Mains
                        } else {
                            category = Category.none
                        }
                    }
                    .frame(width: 100, height: 30)
                    .background((category == Category.Mains) ? Color(hex: "495E57") : Color(hex: "F4CE14"))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    
                    Button("Sides") {
                        if category != Category.Sides {
                            category = Category.Sides
                        } else {
                            category = Category.none
                        }
                    }
                    .frame(width: 100, height: 30)
                    .background((category == Category.Sides) ? Color(hex: "495E57") : Color(hex: "F4CE14"))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    
                    Button("Desserts") {
                        if category != Category.Desserts {
                            category = Category.Desserts
                        } else {
                            category = Category.none
                        }
                    }
                    .frame(width: 100, height: 30)
                    .background((category == Category.Desserts) ? Color(hex: "495E57") : Color(hex: "F4CE14"))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                }
            }
            
            
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink(destination: DishDetails(dish: dish)) {
                            HStack {
                                VStack {
                                    Text(dish.title ?? "")
                                    Text(dish.dishDescription ?? "")
                                    Text(dish.price ?? "")
                                }
                                
                                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            if !isDataFetched {
                PersistenceController.shared.clear() //clear all menu items from database
                getMenuData()
                isDataFetched = true
            }
            
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let urlObject = URL(string: urlString)!
        let urlRequest = URLRequest(url: urlObject)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            if let menuData = data {
                let decoder = JSONDecoder()
                if let menuItems = try? decoder.decode(MenuList.self, from: menuData) {
                    for item in menuItems.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = item.title
                        dish.image = item.image
                        dish.price = item.price
                        dish.dishDescription = item.description
                        dish.category = item.category
                    }
                }
                
                try? viewContext.save()
                
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        let searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let categoryPredicate = NSPredicate(format: "category == %@", category.rawValue)
        
        if(searchText.isEmpty && category == Category.none) {
            return NSPredicate(value: true)
        }
        else if (searchText.isEmpty) {
            return categoryPredicate
        }
        else if (category == Category.none) {
            return searchPredicate
        }
        else {
            return NSCompoundPredicate(type: .and, subpredicates: [searchPredicate, categoryPredicate])
        }
    }
}

#Preview {
    Menu()
}
