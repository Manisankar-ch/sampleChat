//
//  HomeView.swift
//  testSampleApp
//
import SwiftUI

struct HomeView: View {
    @State var members: ChatroomList? = nil
    @State var isLoading: Bool = false
    var body: some View {
        
        VStack(spacing: 0) {
            ProfileView()
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                if let statusList = members?.statusList {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            TopStatusView(status: StatusView(thumbnailUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg", id: "self", name: "Me", statusThumbnailUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg", isSeen: false), isSelf: true)
                            ForEach(statusList, id: \.id) { status in
                                TopStatusView(status: status)
                            }
                        }
                    }
                }
                Spacer(minLength: 20)
                
                if let chatRooms = members?.chatrooms {
                    VStack {
                        if #available(iOS 16.0, *) {
                            NavigationStack {
                                List {
                                    
                                    ForEach(Array(chatRooms.enumerated()), id: \.element.id) { (index, room) in
                                        NavigationLink(destination: ChatRoomDetailView(member: room)) {

                                            ChatRoomListView(member: room)
                                        }
                                        
                                        .swipeActions {
                                            Button(role: .destructive) {
                                                members?.chatrooms.remove(at: index)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            Button(role: .none) {
                                                print("-----notification")
                                            } label: {
                                                Label("notification", systemImage: "bell")
                                            }
                                        }
                                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    }
                                    
                                }
                                
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .background(Color.appWhite)
                    .clipShape(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 40))
                    
                } else {
                    Text("No chat rooms found")
                }
            }
            Spacer()
                .frame(height: 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear {
            getRoomDetails()
        }
        .background(
            LinearGradient(colors: [Color.loginButtonGradient3, Color.white], startPoint: .top, endPoint: .bottom))
        
    }
    
    func getRoomDetails() {
        self.isLoading.toggle()
        if let url = Bundle.main.url(forResource: "chatRooms", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                members = try decoder.decode(ChatroomList.self, from: data)
            } catch {
                print("Error: \(error)")
            }
        }
        self.isLoading.toggle()
    }
}

#Preview {
    HomeView()
}


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

struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


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


struct ChatRoomDetailView: View {
    var member: Chatroom
    
    var body: some View {
        VStack {
            Text("Chat Room Details")
                .font(.title)
                .padding()
            
            Text("Name: \(member.name)")
                .font(.headline)
            Text("Last Message: \(member.lastMessage.content)")
                .font(.subheadline)
            Spacer()
        }
        .padding()
        .navigationTitle(member.name)
    }
}
