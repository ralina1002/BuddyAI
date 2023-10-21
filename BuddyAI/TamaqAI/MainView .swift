
import SwiftUI

struct Article: Identifiable, Decodable {
    var id: UUID { return UUID() }
    let title: String
    let content: String
}

struct SwipeInfo: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

struct SwipeableView: View {
    let swipeInfos: [SwipeInfo]

    var body: some View {
        TabView {
            ForEach(swipeInfos.indices) { index in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blColor.opacity(0.2), Color.mainColor.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                    
                    HStack {
                        if index == 0 { // Check if it's the first slider
                            Image("coco") // Add the image named "coco"
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 170) // Making the image bigger

                            // Moved the text "Привет" to the left, right after the image ends
                            VStack(alignment: .leading) {
                                Text(swipeInfos[index].title)
                                    .font(.headline)
                                Text(swipeInfos[index].content)
                            }
                        } else {
                            Spacer()
                            VStack {
                                Text(swipeInfos[index].title)
                                    .font(.headline)
                                Text(swipeInfos[index].content)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height: 200)
    }
}

struct MainView: View {
    let articles: [Article] = loadArticles()
    let swipeInfos: [SwipeInfo] = [
        SwipeInfo(title: "Привет!👋🏻", content: "Готов познать удивительные возможности Искусственного Интеллекта?"),
        SwipeInfo(title: "Что делает это приложение?", content: "От природных явлений до космических исследований – здесь ты найдешь ответы на все свои вопросы!"),
        SwipeInfo(title: "Как им пользоваться?", content: "Создай свой профиль в пару кликов и я буду ждать тебя в нашем чате 🚀")
    ]

    @State private var selectedArticle: Article? = nil
    @State private var showingBottomSheet = false
    @State private var name: String = ""
    @State private var age: Int = 4
    @State private var gender: Int = 0
    let genderOptions = ["Мужской", "Женский", "Не указано"]

    var body: some View {
        NavigationView {
            VStack {
    
                Text("BuddyAI")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(.top, -50)

                SwipeableView(swipeInfos: swipeInfos)

                HStack {
                    Text("А вы знали, что...?")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(red: 93 / 255, green: 148 / 255, blue: 147 / 255))
                        .padding(.leading)
                    Spacer()
                }

                ZStack {
                    Color.gray.opacity(0.2)
                        .cornerRadius(50)
                        .shadow(radius: 5)
                    if let article = selectedArticle {
                        VStack {
                            Text(article.title).font(.headline)
                            Text(article.content).font(.subheadline)
                        }
                        .padding()
                        .multilineTextAlignment(.center)
                    }
                }
                .frame(width: 350, height: 200)
                .cornerRadius(10)
                .onTapGesture {
                    selectedArticle = articles.randomElement()
                }

                NavigationLink("Хочу знать больше!", destination: ChatScreen())
                    .padding()
                    .frame(width: 270, height: 50)
                    .background(Color(red: 93 / 255, green: 148 / 255, blue: 147 / 255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 15)

                Button("Создать Профиль") {
                    showingBottomSheet.toggle()
                }
                .padding()
                .frame(width: 200, height: 40)
                .background(Color.blColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.top, -1)
            }
            .padding()
            .sheet(isPresented: $showingBottomSheet) {
                ProfileCreationBottomSheetView(name: $name, age: $age, gender: $gender, genderOptions: genderOptions)
                    .presentationDetents([.height(300), .medium])
            }
        }
    }
}

struct ProfileCreationBottomSheetView: View {
    @Binding var name: String
    @Binding var age: Int
    @Binding var gender: Int
    let genderOptions: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Введите свои данные:")
                         .font(.headline)
                         .padding()
            
            TextField("Имя", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))

            HStack {
                Text("Укажите возраст:")
                Picker("", selection: $age) {
                    ForEach(4...21, id: \.self) { ageValue in
                        Text("\(ageValue)").tag(ageValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: 100)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .accentColor(.black)
                Text("лет")
            }
            .padding()

            HStack {
                Text("Пол:")
                Picker("", selection: $gender) {
                    ForEach(genderOptions, id: \.self) { option in
                        Text(option).tag(genderOptions.firstIndex(of: option) ?? 0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: 150)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .accentColor(.black)

                Button("Сохранить") {
                    UserDefaults.standard.set(age, forKey: "userAge")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.blColor))
                .foregroundColor(.white)
            }
            .padding()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.mainColor.opacity(0.3)))
    }
}

func loadArticles() -> [Article] {
    if let url = Bundle.main.url(forResource: "articles", withExtension: "json"),
       let data = try? Data(contentsOf: url),
       let decodedArticles = try? JSONDecoder().decode([Article].self, from: data) {
        return decodedArticles
    } else {
        return []
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

