//
//  TabBar.swift
//  demo
//
//  Created by User on 2022/11/22.
//

import SwiftUI

struct TabBar: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @State var color: Color = .teal
    @State var tableItemWidth: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 20 // iphone se 底部没有，值为0；其他大部分机型是34；此处用于适配iphone se
            HStack {
                buttons
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: hasHomeIndicator ? 88 : 62 , alignment:  .top)
            .background(.ultraThinMaterial, in:
                            RoundedRectangle(cornerRadius: hasHomeIndicator ? 34 : 0, style: .continuous))
            //背景圆
            .background(
                background
                    .padding(.horizontal, 8)
            )
            //线条
            .overlay(
                overlay
                    .padding(.horizontal, 8)
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .strokStyle(cornerRadius: 343)
        .ignoresSafeArea()
        }
    }
    var buttons: some View{
        ForEach(tabItems) { item in
            Button{
                withAnimation(.spring(response: 0.3, dampingFraction: 1)) {  //动画效果
                    selectedTab = item.tab
                    color = item.color
                }
            } label:
            {
                VStack(spacing: 0) {
                    Image(systemName: item.icon)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                        .frame(width: 44, height: 29)
                    Text(item.text)
                        .font(.caption2)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(selectedTab == item.tab ? .primary: .secondary)
            .blendMode(selectedTab == item.tab ? .overlay : .normal)    //融合模式
            //自适应屏幕宽度
            .overlay( //使用overlay不影响外观
                GeometryReader { proxy in
                    // 使用clear不可见
                    //作用是监听，刷新
                    Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
                }
            )
            .onPreferenceChange(TabPreferenceKey.self) { value in
                tableItemWidth = value
            }
            
        }
    }
    
    var background: some View {
        HStack {
            if selectedTab == .library { Spacer() }
            if selectedTab == .explore { Spacer() }
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            Circle().fill(color).frame(width: tableItemWidth)
            if selectedTab == .home { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .notifications { Spacer() }
        }
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .library { Spacer() }
            if selectedTab == .explore { Spacer() }
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            
            Rectangle()
                .fill(color)
                .frame(width: 28, height:5)
                .cornerRadius(3)
                .frame(width: tableItemWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .home { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .notifications { Spacer() }
            
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
