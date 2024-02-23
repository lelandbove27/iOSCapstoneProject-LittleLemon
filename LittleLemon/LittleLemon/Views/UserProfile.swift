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
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("First Name: \(firstName ?? "")")
            Text("Last Name: \(lastName ?? "")")
            Text("Email: \(email ?? "")")
            Spacer()
            Button("Logout") {
                UserDefaults.standard.setValue(false, forKey: keyIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    UserProfile()
}
