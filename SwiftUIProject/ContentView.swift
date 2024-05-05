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
    
    var body: some View {
        VStack {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    LoginOrSignUpView()
                }
            } else {
                NavigationView {
                    LoginOrSignUpView()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .flagsChanged)) { _ in
            DispatchQueue.main.async {
                self.isInternetConnected = self.networkMonitor.isConnectedToNetwork
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}




#Preview {
    ContentView()
}
