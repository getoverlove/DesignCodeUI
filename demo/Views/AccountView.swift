//
//  AccouView.swift
//  demo
//
//  Created by User on 2022/11/20.
//

import SwiftUI

struct AccountView: View {
    @State var isDeleted = false
    @State var isPinned = false
    @Environment(\.presentationMode) var presentationMode  //用于sheet跳转过来navigation后再取消
    
    var body: some View {
        NavigationView{
            List {
                profile
                menu
                links
            }
            .listStyle(.sidebar)
            .navigationTitle("Account")
            //增加一个Done按钮用于关闭搜索列表
            .navigationBarItems(trailing: Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done").bold()
            })
        }
    }
    
    var profile: some View{
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    HexagonView()
                        .offset(x: -50, y: -100)
                )
                .background(
                    BlobView()
                        .offset(x: 200, y: 0)
                        .scaleEffect(0.5)
                    
                )
            Text("skxu")
                .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text("China")
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var menu: some View{
        Section{
            NavigationLink(destination: HomeView())
            {
                Label("Settings", systemImage: "gear")
                //                            .accentColor(.primary)  //强调色
            }
            //导航推荐下面这种方式，更干净
            NavigationLink{
                //                        ContentView()  //等同第一种
                Text("you need a skxu")
            } label: {
                Label("Skxu", systemImage: "creditcard")
            }
            NavigationLink { HomeView() } label: {
                Label("Help", systemImage: "questionmark")
                    .imageScale(.small)
            }
            
        }
        .accentColor(.primary)  //强调色
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
        
    }
    var links: some View{
        Section {
            if !isDeleted{
                Link(destination: URL(string: "https://apple.com")!) {
                    HStack {
                        Label("Website", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button(action: { isDeleted = true }) {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                    pinButton
                    
                    
                }
            }
            Link(destination: URL(string: "https://bilibili.com")!) {
                HStack {
                    Label("Bilibili", systemImage: "tv")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }
            .swipeActions {
                pinButton
            }
        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)
    }
    
    var pinButton: some View{
        Button{ isPinned.toggle() } label: {
            if isPinned {
                Label("Pin", systemImage: "pin.slash")
            }
            else {
                Label("Pin", systemImage: "pin")
                
            }
        }
        .tint(isPinned ? .gray : .yellow)
    }
}

struct AccouView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
