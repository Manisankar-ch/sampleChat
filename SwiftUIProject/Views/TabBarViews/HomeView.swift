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
                        List(Array(chatRooms.enumerated()), id: \.element.id) { (index, room) in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: ChatRoomDetailView(member: room), label: {
                                    EmptyView()
                                        .opacity(0.0)
                                })
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
