//
//  NavigationBar.swift
//  demo
//
//  Created by User on 2022/11/26.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    @Binding var hasScrolled: Bool
    @State var showSearch = false
    @State var showAccount = false
    var body: some View {
        ZStack {
            Color.clear   //叠加一个无色层，自下而上
                .background(.ultraThinMaterial) //设置背景
                .blur(radius: 10)  //融合模糊两层
                .opacity(hasScrolled ? 1 : 0)  // 预览有问题，需要用模拟器
            
            Text(title)
//                .modifier(AnimatableFontModifier(size: hasScrolled ? 22 : 34 ))
//                .font(.largeTitle.weight(.bold))
                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                .frame(maxWidth: .infinity, alignment: .leading) //文本内容靠左
                .padding(.leading, 20) //文本靠左
                .padding(.top, 20)
            
            HStack(spacing: 16) {
                Button {
                    showSearch = true
                } label:{
                    Image(systemName: "magnifyingglass")
                        .font(.body.weight(.bold))
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in:
                                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                        )
                    .strokStyle(cornerRadius: 14)
                }
                .sheet(isPresented: $showSearch) {  //显示搜索列表
                    SearchView()
                }

                
                Button{
                    showAccount = true
                } label: {
                    Image("Avatar Default")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .padding(8)
                        .background(.ultraThinMaterial, in:
                                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                        )
                    .strokStyle(cornerRadius: 18)
                }
                .sheet(isPresented: $showAccount) {  //显示搜索列表
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)
        }
        .frame(height: hasScrolled ? 44 : 70) //设定高度
        .frame(maxHeight: .infinity, alignment: .top) //置顶
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured", hasScrolled: .constant(false))
    }
}
