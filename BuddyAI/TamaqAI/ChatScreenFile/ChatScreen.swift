//
//  ChatScreen.swift
//  TamaqAI
//
//  Created by Ralina on 05.08.2023.
//
import SwiftUI
import Combine
import UIKit

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct ChatScreen: View {
    @State private var isTyping: Bool = false
    @State var chatMessages: [ChatMessage] = ChatMessage.sampleMessages
    @State var messageText: String = ""
    @State var cancellables = Set<AnyCancellable>()
    @State var listCount: Int = 0
    @State var lol = ""
      @State var kek = ""
      @State var pip = ""
    @State var scrollToBottom: Bool = false
    @State var textViewValue = String()
    @State var textViewHeight: CGFloat = 50.0
    @State private var editorHeight: CGFloat = 40
    @State private var text = "Testing text"
    @State private var isMenuOpen = false
    private var maxHeight: CGFloat = 250
    @State private var isEditing: Bool = false

    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Image("coach")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 3)
                    
                    VStack(alignment: .leading) {
                        Text("Ассистент")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text("Online")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding()
                
                ScrollViewReader { scrollViewProxy in
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(chatMessages, id: \.id) { message in
                                messageView(message: message)
                                    .id(message.id)
                                    .font(.system(size: 17))
                            }
                            .onChange(of: chatMessages.count) { _ in
                                if scrollToBottom {
                                    scrollToLastMessage(scrollViewProxy: scrollViewProxy)
                                }
                            }
                        }
                    }
                    .onAppear {
                        scrollToLastMessage(scrollViewProxy: scrollViewProxy)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                        scrollToBottom = true
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        scrollToBottom = false
                    }
                }
                .gesture(DragGesture().onChanged { _ in
                              // Handle the swipe gesture to hide the keyboard
                              hideKeyboard()
                          })
                
                if isTyping {
                    withAnimation(.easeInOut) {
                        HStack {
                            Text("Ассистент печатает...")
                                .foregroundColor(.black)
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                        .padding(.horizontal)
                    }
                }

                
                HStack {
                    ResizableTextView(text: $textViewValue, height: $textViewHeight, placeholderText: "Введи сообщение")
                        .foregroundColor(.white)
                        .frame(height: textViewHeight < 160 ? self.textViewHeight : 160)
                        .cornerRadius(16)
                    
                    Button(action: {
                        sendMessage()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20))
                            .frame(width: 40, height: 40)
                            .background(Color.mainColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
            }
            .padding()
        }
    }

    
    func messageView(message: ChatMessage) -> some View {
        HStack {
            if message.sender == .user { Spacer() }
            
            Text(message.content)
                .foregroundColor(message.sender == .user ? .white : .white)
                .padding()
                .background(message.sender == .user ? Color.gray.opacity(0.8) : Color.mainColor.opacity(0.8))
                .cornerRadius(16)
                .fixedSize(horizontal: false, vertical: true)
                .contextMenu {
                                Button(action: {
                                    // Copy the message to clipboard
                                    UIPasteboard.general.string = message.content
                                }) {
                                    Text("Copy")
                                    Image(systemName: "doc.on.doc")
                                }
                                Button(action: {
                                    // Delete the message
                                    deleteMessage(message: message)
                                }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
            
            if message.sender == .gpt { Spacer() }
        }
    }
    
    func fetchConversationID(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://fastapi-38am.onrender.com/chat/") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                if responseString.contains("detail: Method Not Allowed") {
                    print("Invalid response: \(responseString)")
                    completion(nil)
                } else {
                    let cleanedResponseString = responseString.replacingOccurrences(of: "\"", with: "")
                    completion(cleanedResponseString)
                }
            } else {
                print("Failed to convert data to string")
                completion(nil)
            }
        }.resume()
    }


    func deleteMessage(message: ChatMessage) {
        withAnimation {
            chatMessages.removeAll { $0.id == message.id }
        }
    }
    
    func sendMessage() {
        lol = textViewValue
               let trimmedMessage = textViewValue.trimmingCharacters(in: .whitespacesAndNewlines)
               if !trimmedMessage.isEmpty {
                   let myMessage = ChatMessage(id: UUID().uuidString, content: trimmedMessage, dataCreated: Date(), sender: .user)
                   chatMessages.append(myMessage)
                   textViewValue = "" // Clear the input text view
                   
                   // Show typing animation
                   isTyping = true
                   let prompt = pip + "\n" + kek + "\n" + lol
                   print(prompt)
                   let url = URL(string: "https://fastapi-38am.onrender.com/chat/")!
                   let requestData = ["prompt": prompt]
                   //let session = URLSession.shared
                   _ = URLSession.shared
                   var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.setValue("application/json", forHTTPHeaderField: "Accept")
                   
                   do {
                       let requestData = try JSONSerialization.data(withJSONObject: requestData, options: [])
                       request.httpBody = requestData
                   } catch {
                       print("Error encoding JSON: \(error)")
                       return
                   }
                   
                   URLSession.shared.dataTask(with: request) { data, response, error in
                       if let error = error {
                           print("Error: \(error)")
                           return
                       }
                       
                       guard let data = data else {
                           print("No data received")
                           return
                       }
                       
                       if let responseString = String(data: data, encoding: .utf8) {
                           // Remove quotes from the response string
                           let cleanedResponseString = responseString.replacingOccurrences(of: "\"", with: "")
                                                                   .replacingOccurrences(of: "\\n", with: "\n")
                           
                           DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                               // Hide typing animation and display bot message
                               isTyping = false
                               let botMessage = ChatMessage(id: UUID().uuidString, content: cleanedResponseString, dataCreated: Date(), sender: .gpt)
                               chatMessages.append(botMessage)
                               kek = botMessage.content
                               pip = lol
                    }
                } else {
                    print("Failed to convert response data to string")
                }
            }.resume()
        } else {
            print("oooooops...")
        }
    }

        
        
        
        func scrollToLastMessage(scrollViewProxy: ScrollViewProxy) {
            withAnimation {
                scrollViewProxy.scrollTo(chatMessages.last?.id, anchor: .bottom)
            }
        }
        
        private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    struct ChatScreen_Previews: PreviewProvider {
        static var previews: some View {
            ChatScreen()
    }
}



struct ChatMessage {
    let id: String
    let content: String
    let dataCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case user
    case gpt
}

extension ChatMessage {
    
    static let sampleMessages = [
        ChatMessage(id: UUID().uuidString, content: "Привет, я твой личный ассистент, чем я могу помочь?", dataCreated: Date(), sender: .gpt)
    ]
}
