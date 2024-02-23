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
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                Button("Register") {
                    if(!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty) {
                        UserDefaults.standard.setValue(firstName, forKey: keyFirstName)
                        UserDefaults.standard.setValue(lastName, forKey: keyLastName)
                        UserDefaults.standard.setValue(email, forKey: keyEmail)
                        UserDefaults.standard.setValue(true, forKey: keyIsLoggedIn)
                        isLoggedIn = true
                    }
                }
            }
            .onAppear() {
                if(UserDefaults.standard.bool(forKey: keyIsLoggedIn)) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
