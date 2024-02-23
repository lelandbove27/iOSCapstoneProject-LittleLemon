//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Leland Bove on 2/22/24.
//

import SwiftUI

let keyFirstName : String = "firstKey"
let keyLastName : String = "lastKey"
let keyEmail : String = "emailKey"
let keyIsLoggedIn : String = "isLoggedInKey"


struct Onboarding: View {
    @State var firstName : String = ""
    @State var lastName : String = ""
    @State var email : String = ""
    @State var isLoggedIn = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                ZStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .background(Color.white)
              
                
                Spacer()
                
                Text("Welcome to the Little Lemon Mobile App!")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Sign in here")
                
                TextField("First Name", text: $firstName)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .frame(width: 350, height: 30)
                    .background(Color(hex: "EEEEEE"))
                    .cornerRadius(10)
                    
                    
                TextField("Last Name", text: $lastName)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .frame(width: 350, height: 30)
                    .background(Color(hex: "EEEEEE"))
                    .cornerRadius(10)
                
                TextField("Email", text: $email)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .frame(width: 350, height: 30)
                    .background(Color(hex: "EEEEEE"))
                    .cornerRadius(10)
                    
                
                Spacer()
                
                Button("Register") {
                    if(!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty) {
                        UserDefaults.standard.setValue(firstName, forKey: keyFirstName)
                        UserDefaults.standard.setValue(lastName, forKey: keyLastName)
                        UserDefaults.standard.setValue(email, forKey: keyEmail)
                        UserDefaults.standard.setValue(true, forKey: keyIsLoggedIn)
                        isLoggedIn = true
                    }
                }
                .frame(width: 100, height: 50)
                .background(Color(hex: "F4CE14"))
                .foregroundColor(.black)
                .cornerRadius(30)
            }
            .onAppear() {
                if(UserDefaults.standard.bool(forKey: keyIsLoggedIn)) {
                    isLoggedIn = true
                }
            }
            .background(Color(hex: "495E57"))
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    Onboarding()
}
