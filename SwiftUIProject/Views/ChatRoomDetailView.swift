//
//  ChatRoomDetailView.swift
//  SwiftUIProject
//
//  Created by Mani sankar on 06/01/25.
//
import SwiftUI

struct ChatRoomDetailView: View {
    var member: Chatroom
    @Environment(\.dismiss) var dismiss
    @State private var newMessage: String = ""
    @State private var showAddFiles: Bool = false
    private let addFiles: [String] = ["camera", "photo", "folder", "music.note"]
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage? = nil
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        NavigationView {
            VStack {

                if #available(iOS 16.0, *) {
                    List(Array(member.messages.enumerated()), id: \.element.id) { (index, message) in
                        MessageView(message: message)
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    List(Array(member.messages.enumerated()), id: \.element.id) { (index, message) in
                        MessageView(message: message)
                    }
                }
                if showAddFiles {
                    HStack() {
                        ForEach(Array(addFiles.enumerated()), id: \.offset) {(index, fileName) in
                            Button(action: {
                                isImagePickerPresented.toggle()
                            }) {
                                Image(systemName: fileName)
                            }
                            .buttonStyle(.plain)
                            index != addFiles.count - 1 ? Spacer() : nil
                        }
                    }
                    .padding()
                    .background(Color.green)
                    .transition(.move(edge: .bottom))
                    .clipShape(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 20))
                }
                HStack(spacing: 4) {
                    Button(action: {
                        withAnimation {
                            showAddFiles.toggle()
                        }
                    }
                           
                    ) {
                        Image(systemName: "link")
                            .padding()
                    }
                    .buttonStyle(.plain)
                    HStack {
                        Spacer()
                        TextField("Enter message", text: $newMessage)
                        Image(systemName: "face.smiling")
                    }
                    .padding(.all, 8)
                    .background(Color.blue)
                    .clipShape(.capsule)
                    Button(action: sendMessage) {
                        Image(systemName: newMessage.trim().isEmpty ? "camera" : "paperplane")
                    }
                   
                    Spacer()
                }
                .frame(alignment: .leading)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .border(Color.blue, width: 1)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
                    }
            .padding(.all, 1)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "chevron.backward")
                    }
                    .onTapGesture {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        AsyncImage(url: URL(string: member.thumbnailUrl)!) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .clipShape(.capsule)
                        .frame(width: screenWidth * 0.10, height: screenWidth * 0.10)
                        .padding(.all, 6)
                        VStack {
                            Text("Custom Title")
                                .font(.headline)
                            Text("Subtitle")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 20) {
                        Image(systemName: "phone")
                        Image(systemName: "video")
                    }

                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func sendMessage() {
        if !newMessage.trim().isEmpty {
            newMessage = ""
        } else {
            selectedImage = nil
            isImagePickerPresented.toggle()
            
        }
          
       }
}

#Preview {
    ChatRoomDetailView(member: Chatroom.init(id: "", name: "Chat Room", participants: [], messages: [Message(id: "1", senderId: "user1", content: "test", timestamp: "", messageType: MessageType.text),
                                             
                                                                                                     Message(id: "2", senderId: "user2", content: "test", timestamp: "", messageType: MessageType.text)], lastMessage: Message.init(id: "", senderId: "user2", content: "Hello World!", timestamp: "", messageType: MessageType.text), thumbnailUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg", unreadMessageCount: 0))
}



struct MessageView: View {
    var message: Message
    init(message: Message) {
        self.message = message
    }
    var body: some View {
        HStack() {
            if message.senderId == "user1" {
                Spacer()
            }
            Text("Hello World!")
                .border(Color.red)
            if message.senderId != "user1" {
                Spacer()
            }
        }
            .frame(maxWidth: .infinity)
    }
    
    
}
