//
//  ChatRoomListView.swift
//  SwiftUIProject
//
//  Created by Mani sankar on 06/01/25.
//

import SwiftUI

struct ChatRoomListView: View {
    
    var member: Chatroom
    @State private var offset: CGFloat = 0
    @State private var showView: Bool = false
    
    
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        // Foreground view (Swipable content)
        HStack {
            AsyncImage(url: URL(string: member.thumbnailUrl)!) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .clipShape(Capsule())
            .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
            .padding(5)
            
            VStack(spacing: 0) {
                HStack {
                    Text(member.name)
                        .foregroundStyle(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .font(.caption)
                    Text(formatMessageDate(member.lastMessage.timestamp))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .font(.footnote)
                }
                .padding([.top, .horizontal], 5)
                
                HStack {
                    Text(member.lastMessage.content)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .font(.caption2)
                    
                    if member.unreadMessageCount > 0 {
                        Text("\(member.unreadMessageCount)")
                            .font(.footnote)
                            .padding(6)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                .padding([.bottom, .horizontal], 5)
            }
        }
        .background(Color.white)
    }
    
    func formatMessageDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let messageDate = formatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        let calendar = Calendar.current
        
        // Check if the message was sent today
        if calendar.isDateInToday(messageDate) {
            formatter.dateFormat = "hh:mm a"
            return formatter.string(from: messageDate)
        }
        
        // Check if the message was sent yesterday
        if calendar.isDateInYesterday(messageDate) {
            return "Yesterday"
        }
        if isDateInThisWeek(date: messageDate, calendar: calendar) {
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.dateFormat = "EEEE"
            return weekdayFormatter.string(from: messageDate)
        } else {
            
            // For other days (Monday - Friday)
            formatter.dateFormat = "dd/MM/yy"
            return formatter.string(from: messageDate)
        }
        
    }
    
    func isDateInThisWeek(date: Date, calendar: Calendar) -> Bool {
        let currentDate = Date()
        
        // Get the start of the current week
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else {
            return false
        }
        return calendar.isDate(date, inSameDayAs: startOfWeek) || (date > startOfWeek && date < currentDate)
    }
}
