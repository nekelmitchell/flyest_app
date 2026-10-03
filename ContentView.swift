//
//  ContentView.swift
//

import SwiftUI

/// Content view bar that surfaces the five core Flyest pillars plus a profile tab.
struct ContentView: View {
    var body: some View {
        TabView {
            SafetyHomeView()
                .tabItem { Label("Safety", systemImage: "shield.checkerboard") }

            NewsView()
                .tabItem { Label("News", systemImage: "newspaper.fill") }

            CommunityView()
                .tabItem { Label("Community", systemImage: "person.3.fill") }

            ReviewsView()
                .tabItem { Label("Reviews", systemImage: "star.fill") }

            LanguageView()
                .tabItem { Label("Language", systemImage: "character.bubble.fill") }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppStore())
        .environmentObject(LocationManager())
}
