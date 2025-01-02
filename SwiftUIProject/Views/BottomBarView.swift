//
//  BottomBarView.swift
//  testSampleApp
//
//  Created by Mani dev on 27/12/24.
//

import SwiftUI

struct BottomBarView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        if #available(iOS 18.0, *) {
            TabView(selection: $selectedTab) {
                Tab("Message", systemImage: "message.fill", value: 0) {
                    HomeView()
                }
                Tab("Calls", systemImage: "phone.fill", value: 1) {
                    Text("2")
                }
                Tab("Contacts", systemImage: "person.crop.circle.fill", value: 2) {
                    Text("3")
                }
                Tab("Settings", systemImage: "gearshape", value: 3) {
                    Text("4")
                }
            }
            .tabViewStyle(.sidebarAdaptable)
        } else {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Message")
                    }
                Text("2")
                    .tabItem {
                        Image(systemName: "phone.fill")
                        Text("Calls")
                    }
                Text("3")
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Contacts")
                    }
                Text("4")
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }
        }
    }
}

#Preview {
    BottomBarView()
}
