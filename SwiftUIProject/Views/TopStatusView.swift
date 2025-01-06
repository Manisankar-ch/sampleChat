//
//  TopStatusView.swift
//  SwiftUIProject
//
//  Created by Mani sankar on 06/01/25.
//
import SwiftUI

struct TopStatusView: View {
    var status: StatusView
    var isSelf: Bool = false
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        VStack {
            AsyncImage(url: URL(string: status.thumbnailUrl)!) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .clipShape(.capsule)
            .overlay(
                Capsule()
                    .inset(by: -4)
                    .stroke(status.isSeen ? Color.gray : Color.green, lineWidth: 4)
            )
            .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
            .padding(.all, 6)
            
            Text(status.name)
                .foregroundStyle(Color.appWhite)
                .font(.system(size: 8))
                .lineLimit(1)
        }
        
        .frame(width: screenWidth * 0.17)
        
    }
}
