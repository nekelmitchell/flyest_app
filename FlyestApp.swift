//
//
//

import SwiftUI

@main
struct FlyestApp: App {
    @StateObject private var store = AppStore()
    @StateObject private var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(locationManager)
                .tint(.accentColor)
        }
    }
}
