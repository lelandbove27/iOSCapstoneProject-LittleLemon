//
//  DishDetails.swift
//  LittleLemon
//
//  Created by Leland Bove on 2/22/24.
//

import SwiftUI

struct DishDetails: View {
    let dish : Dish
    
    var body: some View {
        VStack {
            Text(dish.title ?? "")
                .font(.largeTitle)
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 300, height: 300)
            Text("\(dish.dishDescription ?? "")")
                .padding(20)
            Text("Category: \(dish.category ?? "")")
                .padding(20)
            Text("Price: $\(dish.price ?? "")")
                .padding(20)
        }
        .background(Color(hex: "F4CE14"))
        .padding(20)
    }
}


