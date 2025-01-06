//
//  ProfileView.swift
//  SwiftUIProject
//
//  Created by Mani sankar on 06/01/25.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        HStack {
            VStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .padding(.all, 15)
            }
            .background(Color.gray)
            .frame(width: screenWidth * 0.13, height: screenWidth * 0.13)
            .clipShape(.capsule)
            
            Text("Home")
                .frame(maxWidth: .infinity)
                .font(.title)
                .foregroundStyle(Color.appWhite)
            
            AsyncImage(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg")!) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
            .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
