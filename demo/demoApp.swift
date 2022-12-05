//
//  demoApp.swift
//  demo
//
//  Created by User on 2022/11/19.
//

import SwiftUI

@main
struct demoApp: App {
    @StateObject var model = Model()
    var body: some Scene {
        WindowGroup {
//            AccountView()
            ContentView()
                .environmentObject(model)
        }
    }
}
