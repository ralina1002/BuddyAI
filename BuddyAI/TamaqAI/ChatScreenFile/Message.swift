//
//  Message.swift
//  TamaqAI
//
//  Created by Ralina on 05.08.2023.
//
import Foundation

struct Message: Hashable, Equatable, Identifiable {
    var id = UUID()
    var content: String
    var user: User
}


struct DataSource {
    static let firstUser = User(name: "Maria Shadapova", avatar: "coach")
    static var secondUser = User(name: "Coach", avatar: "cooach", isCurrentUser: true)
    static let messages = [
        Message(id: UUID(), content: "Hi, I really love your templates and I would like to buy the chat template", user: DataSource.firstUser),
        Message(id: UUID(), content: "Thanks, nice to hear that, can I have your email please?", user: DataSource.secondUser),
        Message(id: UUID(), content: "😇", user: DataSource.firstUser),
        Message(id: UUID(), content: "Oh actually, I have just purchased the chat template, so please check your email, you might see my order", user: DataSource.firstUser),
        Message(id: UUID(), content: "Great, wait me a sec, let me check", user: DataSource.secondUser),
        Message(id: UUID(), content: "Sure", user: DataSource.firstUser)
    ]
}
