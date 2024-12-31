//
//  LoginOrSignUpView.swift
//  SwiftUIProject
//
//  Created by Mani Sankar on 03/05/24.
//

import SwiftUI

struct LoginOrSignUpView: View {
    let images = ["FaceBook", "Google", "Apple"]
    
    func actionOnSocialMediaIcons(selectedIndex:Int) {
        
    }
    
    var body: some View {
        VStack {
            
            Text("Connect friends easily & quickly")
                .frame(maxWidth: .infinity)
                .font(.system(size: 68, weight: .regular))
                .padding(.horizontal)
                .foregroundStyle(.appWhite)
                .padding(.top, 10)
            Text("Our chat app is the perfect way to stay connected with friends and family.")
                .padding(.horizontal)
                .padding(.top, 30)
                .foregroundStyle(Color.appWhite.opacity(0.5))
                .font(.system(size: 16, weight: .regular))
            HStack(spacing: 20) { // Adjust spacing between images as needed
                ForEach(Array(images.enumerated()), id: \.element) { index, imageName in
                    Image(imageName)
                        .frame(width: 48, height: 48)
                        .onTapGesture {
                            actionOnSocialMediaIcons(selectedIndex: index)
                        }
                }}
            .padding(.horizontal, 50)
            .padding(.top, 30)
            HStack {
                Rectangle()
                    .fill(LinearGradient(colors: [Color.gray.opacity(0.1), Color.gray], startPoint: .leading, endPoint: .trailing))
                    .frame(maxWidth: .infinity, maxHeight: 2)
                Text("OR")
                    .fontWeight(.bold)
                    .foregroundColor(Color.appWhite)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                Rectangle()
                    .fill(LinearGradient(colors: [Color.gray.opacity(0.1), Color.gray], startPoint: .trailing, endPoint: .leading))
                    .frame(maxWidth: .infinity, maxHeight: 2)
            }
            .padding([.vertical], 30)
            NavigationLink(destination: SignUpView()) {
                Text("Sign up with mail")
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.appWhite)
                    .padding()
                    .background(Color(red: 1, green: 1, blue: 1, opacity: 0.37))
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            HStack {
                Text("Exisitng account?")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.appWhite)
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color.appWhite)
                }
            }
            .padding(.top, 46)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.loginButtonGradient1, Color.loginButtonGradient2,Color.loginButtonGradient3]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }
    
}

#Preview {
    LoginOrSignUpView()
}
