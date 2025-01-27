//
//  SignUpView.swift
//  SwiftUIProject
//
//  Created by Mani Sankar on 02/05/24.
//

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var navigateToHome: Bool = false
    
    func actionOnCreateAccount() {
        navigateToHome = true
    }
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Sign up with Email")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top, 100)
                    Text("Get chatting with friends and family today by signing up for our chat app!")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                        .padding(.top, 20)
                    VStack(spacing: 40) {
                        CustomInputField(userInput: $name,
                                         fieldLabelName: "Your name", placeHolderText: "Enter  name")
                        CustomInputField(userInput: $email, isRightIcon: true,
                                         fieldLabelName: "Email", placeHolderText: "Enter Email")
                        CustomInputField(userInput: $password, isPassword: true,
                                         fieldLabelName: "Password", placeHolderText: "Enter Password")
                        CustomInputField(userInput: $confirmPassword,  isPassword: true,
                                         fieldLabelName: "Confirm Password", placeHolderText: "Confirm Password")
                    }
                    .padding([.top, .bottom], 30)
                }
            }
            Spacer()
            if #available(iOS 16.0, *) {
                Button(action: actionOnCreateAccount) {
                    Text("Create Account")
                        .fontWeight(.heavy)// Display login button
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.appWhite)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.loginButtonGradient1, Color.loginButtonGradient2,Color.loginButtonGradient3]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(10)
                }
                .padding(.bottom, 70)
                .padding(.horizontal)
                .navigationDestination(isPresented: $navigateToHome) {
                    BottomBarView()
                        .navigationBarBackButtonHidden(true)
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SignUpView(name: "firstName", email: "Email", password: "password", confirmPassword: "confirmPassword")
}
