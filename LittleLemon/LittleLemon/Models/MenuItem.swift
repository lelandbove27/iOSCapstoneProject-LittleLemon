//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Leland Bove on 2/22/24.
//

import Foundation

struct MenuItem : Decodable {
    let title : String
    let image : String
    let price : String
    let description : String
    let category: String
}
