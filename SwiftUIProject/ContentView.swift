//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Mani Sankar on 21/04/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    let images = ["FaceBook", "Google", "Apple"]
    @State private var isInternetConnected = true
    @State var email: String = ""
    @State var password: String = ""
    
    let networkMonitor = try! NetworkMonitor()
    func loginAction() {
        print("email text:", email)
        print("password text:", password)
    }
    
    func actionOnSocialMediaIcons(selectedIndex: Int) {
        //To do sign in through social media
        print("selected Index\(selectedIndex)")
    }
    
    
    var body: some View {
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
            CustomInputField(userInput: $email, isRightIcon: true)
            CustomInputField(userInput: $password, isRightIcon: true, isPassword: true)
            
                   
            Spacer()
            
            
            Button(action: loginAction) {
                Text("Login") // Display login button
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10).padding(.horizontal, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: .flagsChanged)) { _ in
            DispatchQueue.main.async {
                self.isInternetConnected = self.networkMonitor.isConnectedToNetwork
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}




#Preview {
    ContentView()
}
