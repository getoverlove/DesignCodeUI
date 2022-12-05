//
//  HomeView.swift
//  demo
//
//  Created by User on 2022/11/24.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()  //返回时在上次的界面
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()  //忽略安全区域
            ScrollView {
                scrollDetection
                featured
                //                Color.clear.frame(height: 1000) //显示滚动条
                Text("courses".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                // 屏幕自适应
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                    if !show {
                        cards
                    } else {
                        ForEach(courses) { course in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y:10 )
                                .opacity(0.3)
                                .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .coordinateSpace(name: "scroll")  //坐标空间, 如果在安全区域后，那么就会加上安全区域的高度
            .safeAreaInset(edge: .top, content: {  //滚动条的安全区域，类似放置刘海旁边的显示
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled) // Binding数据需要加$
                //                .opacity(hasScrolled ? 1 : 0)  // 预览有问题，需要用模拟器
            )
            if show {
                detail
            }
        }
        .statusBar(hidden: !showStatusBar) //隐藏状态栏
        .onChange(of: show) { newValue in
            withAnimation(.closeCard) {
                if newValue {
                    showStatusBar = false
                } else
                {
                    showStatusBar = true
                }
            }
        }
    }
    var scrollDetection: some View{
        GeometryReader{ proxy in
            //                Text("\(proxy.frame(in: .named("scroll")).minY)")
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0) //默认高度不是0
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut)  // 增加值变化的动画！！
            {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }
    var featured: some View{
        TabView { //水平标签页
            ForEach(featuredCourses) { course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(course: course)
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity) //两个frame来适应屏幕
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / 10), axis: (x: 0, y: 1, z: 0)) //3d 切换效果
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x:0, y:10)
                    //若想要营造视觉差，可以在此后加入overlay
                    //                        .blur(radius: abs(minX) / 100)
                        .overlay(Image(course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 230)
                            .offset(x: 32,y:-80)
                            .offset(x: minX / 2)  // 视觉差
                        )
                    
                    //                    Text("\(proxy.frame(in: .global).minX)")
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never)) // 隐藏标签页小圆点
        .frame(height: 430)
        .background(
            Image("Blob 1")
                .offset(x:250, y:-100)
        )
    }
    
    var cards: some View{
        ForEach(courses) { course in
            CourseItem(namespace: namespace, course: course,show: $show) //为什么加$ ? 用于绑定
                .onTapGesture {  //点击文字就会触发
                    withAnimation(.openCard) {  //增加反弹
                        show.toggle()
                        model.showDetail.toggle()
                        //                                showStatusBar = false
                        selectedID = course.id
                    }
                }
        }
    }
    
    var detail: some View{
        ForEach(courses) { course in
            if course.id == selectedID {
                CourseView(namespace: namespace, course: course, show: $show) //为什么加$ ?
                    .zIndex(1)  //过渡不会立刻消失
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),//duration持续时间
                        removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))
                    ))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
            .environmentObject(Model())  //注意 一定不能忘，不然会崩溃
    }
}
