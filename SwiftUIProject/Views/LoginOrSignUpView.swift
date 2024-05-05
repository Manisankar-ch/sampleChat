//
//  LoginOrSignUpView.swift
//  SwiftUIProject
//
//  Created by Mani Sankar on 03/05/24.
//

import SwiftUI

struct LoginOrSignUpView: View {
    let images = ["FaceBook", "Google", "Apple"]
    
    func actionOnSocialMediaIcons(selectedIndex:Int){
        
    }
    
    var body: some View {
        VStack {
            
            Text("Connect friends easily & quickly")
                .frame(maxWidth: .infinity)
                .font(.system(size: 68,weight: .regular))
                .padding(.horizontal)
                .foregroundStyle(.white)
                .padding(.top, 10)
            Text("Our chat app is the perfect way to stay connected with friends and family.")
                .padding(.horizontal)
                .padding(.top, 30)
                .foregroundStyle(Color.white.opacity(0.5))
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
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                Rectangle()
                    .fill(LinearGradient(colors: [Color.gray.opacity(0.1), Color.gray], startPoint: .trailing, endPoint: .leading))
                    .frame(maxWidth: .infinity, maxHeight: 2)
            }
            .padding(.top, 30)
            .padding(.bottom, 30)
            NavigationLink(destination: SignUpView()) {
                Text("Sign up with mail")
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .background(Color(red: 1, green: 1, blue: 1, opacity: 0.37))
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.horizontal)
            HStack {
                Text("Exisitng account?")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.white)
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color.white)
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
