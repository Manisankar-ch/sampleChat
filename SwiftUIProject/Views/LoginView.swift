//
//  LoginView.swift
//  SwiftUIProject
//
//  Created by Mani Sankar on 02/05/24.
//

import SwiftUI

struct LoginView: View {
    let images = ["FaceBook", "Google", "Apple"]
    @State var email: String = ""
    @State var password: String = ""
    
    func actionOnForgotPassword() {
        
    }
    
    func loginAction() {
        
    }
    
    func actionOnSocialMediaIcons(selectedIndex: Int) {
        
    }
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Login to ChatBox")
                        .font(.system(size: 18,weight: .bold))
                        .padding(.top, 100)
                    Text("Welcome back! Sign in using your social account or email to continue us")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                        .padding(.top, 20)
                    HStack(spacing: 0) { // Adjust spacing between images as needed
                        ForEach(Array(images.enumerated()), id: \.element) { index, imageName in
                            Image(imageName)
                                .frame(width: 48, height: 48)
                                .onTapGesture {
                                    actionOnSocialMediaIcons(selectedIndex: index)
                                }
                        }}
                    .padding(.horizontal, 50)
                    HStack {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color.gray.opacity(0.1), Color.gray], startPoint: .leading, endPoint: .trailing))
                            .frame(maxWidth: .infinity, maxHeight: 2)
                        Text("OR")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                        Rectangle()
                            .fill(LinearGradient(colors: [Color.gray.opacity(0.1), Color.gray], startPoint: .trailing, endPoint: .leading))
                            .frame(maxWidth: .infinity, maxHeight: 2)
                    }
                    CustomInputField(userInput: $email, isRightIcon: true,
                                     fieldLabelName: "Email", placeHolderText: "Enter Email")
                    CustomInputField(userInput: $password, isRightIcon: true, isPassword: true,
                                     fieldLabelName: "Password", placeHolderText: "Enter Password")
                    .padding(.top, 20)
                    
                }
            }
            Spacer()
            Button(action: loginAction) {
                Text("Login")
                    .fontWeight(.heavy)// Display login button
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 40)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10).padding(.horizontal, 10)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.loginButtonGradient1, Color.loginButtonGradient2,Color.loginButtonGradient3]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                
            }
            .padding(.horizontal)
            
            Text("Forgot password?")
                .foregroundColor(Color.labelText)
                .onTapGesture(perform: {
                    actionOnForgotPassword()
                })
                .padding(.bottom, 30)
        }
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}

#Preview {
    LoginView()
}


struct test: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text("test")
                }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        .border(Color.red)
        }
    }
}
