//
//  betatest.swift
//  TamaqAI
//
//  Created by Ralina on 05.08.2023.
//


import SwiftUI
//
//struct ChatScreen: View {
//    @State private var response: String = ""
//    @State private var prompt: String = ""
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//    }
//    var body: some View {
//        NavigationView{
//            ZStack{
//                Color.black.edgesIgnoringSafeArea(.all)
//                VStack {
//                    ScrollView{
//
//                        Text(response)
//                            .foregroundColor(.white)
//                            .padding()
//                    }
//                    HStack{
//                        TextField("Введите запрос", text: $prompt)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(.gray.opacity(0.2))
//                            .cornerRadius(12)
//
//                        Button(action: {
//                            postData()
//                        }, label: {
//                            Text("send")
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(20)
//                        })
//                    }
//                    .padding(.vertical,16)
//                }
//                .padding(.horizontal,16)
//            }
//            .navigationTitle("AICoach")
//        }
//    }
//
//    func postData() {
//        let url = URL(string: "https://fastapi-38am.onrender.com/chat/")!
//        let requestData = ["prompt": prompt]
//
//        let session = URLSession.shared
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
//            request.httpBody = jsonData
//
//            let task = session.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    print("Ошибка при выполнении запроса: \(error.localizedDescription)")
//                    return
//                }
//
//                if let httpResponse = response as? HTTPURLResponse {
//                    if httpResponse.statusCode == 200 {
//                        // Данные успешно получены
//                        if let responseData = data {
//                            // Обработка полученных данных
//                            let responseString = String(data: responseData, encoding: .utf8)
//                            DispatchQueue.main.async {
//                                self.response = responseString ?? ""
//                            }
//                        }
//                    } else {
//                        print("Ошибка сервера. Код ответа: \(httpResponse.statusCode)")
//                    }
//                }
//            }
//
//            task.resume()
//        } catch {
//            print("Ошибка при сериализации данных в формат JSON: \(error.localizedDescription)")
//        }
//    }
//}
//
//struct ChatScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatScreen()
//    }
//}
