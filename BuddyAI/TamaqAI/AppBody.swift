import SwiftUI
struct AppBody: View {
    @State private var selection = 1

    var body: some View {
        TabView(selection: $selection) {
            // Home tab with PageView that contains MainView and some other view (e.g., ChatScreen)
            PageView([AnyView(MainView()), AnyView(ChatScreen())])
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(1)
            
            // Chat tab
            ChatScreen()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
                .tag(2)
        }
    }
}

