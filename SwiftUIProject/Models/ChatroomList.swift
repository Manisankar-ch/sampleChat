//
//  ChatroomList.swift
//  testSampleApp
//
//


import Foundation

struct ChatroomList: Codable {
    let chatrooms: [Chatroom]
    let statusList: [StatusView]
}

struct StatusView: Codable {
    let thumbnailUrl: String
    let id: String
    let name: String
    let statusThumbnailUrl: String
    let isSeen: Bool
}

struct Chatroom: Codable {
    let id: String
    let name: String
    let participants: [Participant]
    let messages: [Message]
    let lastMessage: Message
    let thumbnailUrl: String
    let unreadMessageCount: Int
}

struct Participant: Codable {
    let id: String
    let name: String
}

struct Message: Codable {
    let id: String
    let senderId: String
    let content: String
    let timestamp: String
}
