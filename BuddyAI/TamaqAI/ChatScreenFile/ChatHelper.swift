//
//  ChatHelper.swift
//  TamaqAI
//
//  Created by Ralina on 05.08.2023.
//

import Foundation
import Combine

class ChatHelper : ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    @Published var realTimeMessages = DataSource.messages

    func sendMessage(_ chatMessage: Message) {
        realTimeMessages.append(chatMessage)
        didChange.send(())
    }
}
