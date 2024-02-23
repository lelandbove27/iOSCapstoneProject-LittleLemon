//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Leland Bove on 2/22/24.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: keyFirstName)
    let lastName = UserDefaults.standard.string(forKey: keyLastName)
    let email = UserDefaults.standard.string(forKey: keyEmail)
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
                .font(.largeTitle)
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("First Name: \(firstName ?? "")")
                .font(.title2)
            Text("Last Name: \(lastName ?? "")")
                .font(.title2)
            Text("Email: \(email ?? "")")
                .font(.title2)
            Spacer()
            Button("Logout") {
                PersistenceController.shared.clear()
                UserDefaults.standard.setValue(false, forKey: keyIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            .padding()
            .background(Color(hex: "495E57"))
            .cornerRadius(30)
            .padding()
            
            
            
        }
        .background(Color(hex: "F4CE14"))
    }
        
}

#Preview {
    UserProfile()
}
