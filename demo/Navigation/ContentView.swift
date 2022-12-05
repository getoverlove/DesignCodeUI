//
//  ContentView.swift
//  demo
//
//  Created by User on 2022/11/19.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            switch selectedTab {
            case .home:
                HomeView()
                
            case .explore:
                HomeView()
                
            case .notifications:
                HomeView()
                
            case .library:
                AccountView()
                
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
                .preferredColorScheme(.light)
                .previewDevice("iPhone 11")
            ContentView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 11")
        }
        .environmentObject(Model())
        
    }
}
