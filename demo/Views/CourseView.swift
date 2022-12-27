//
//  CourseView.swift
//  demo
//
//  Created by User on 2022/12/4.
//

import SwiftUI

struct CourseView: View {
    var namespace: Namespace.ID
    var course: Course = courses[0]
    @Binding var show: Bool
    @State var apper = [false, false, false]
    @EnvironmentObject var model: Model
    @State var viewState: CGSize = .zero  // used for gesture
    @State var isDraggable = true
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
                    .opacity(apper[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scroll")
            .onAppear{ model.showDetail = true }
            .onDisappear{ model.showDetail = false }
            .background(Color("Background"))
            
            // gesture effect start
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            .scaleEffect(viewState.width / -500 + 1)
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            // gesture end
            
            .ignoresSafeArea()
            button
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
    }
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            apper[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            apper[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            apper[2] = true
        }
    }
    func fadeOut() {
        apper[0] = false
        apper[1] = false
        apper[2] = false
    }
    func close() {
        withAnimation(.closeCard.delay(0.3)) {
            show.toggle()
            model.showDetail.toggle()
        }
        withAnimation(.closeCard){
            viewState = .zero
        }
        isDraggable = false
    }
    var content: some View{
        Text("sdfsdf")
    }
    
    var cover: some View{
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY //用于视差
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            .frame(height: scrollY > 0 ? 500 + scrollY : 500) //防止负值
            .foregroundColor(.black)
            .background(
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(maxWidth: 500)
                    .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)  //视差
                    .scaleEffect(scrollY / 1000 + 1)  //视差
                    .blur(radius: scrollY / 10)  //视差
            )
            .background(
                Image(course.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "backgroud\(course.id)", in: namespace)
                    .offset(y: -scrollY)  //视差
            )
            .mask(
                RoundedRectangle(cornerRadius: apper[0] ? 0 : 30, style: .continuous) //使用apoer是为了过渡更加平滑
                    .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
                    .offset(y: -scrollY)
            )
            .overlay(
                overlayContent
            )
        }
        .frame(height: 500)
    }
    
    var button: some View{
        Button {
            withAnimation(.closeCard) {
                show.toggle()
                model.showDetail.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.bold())
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    
    var overlayContent: some View{
        VStack(alignment: .leading, spacing: 12){
            Text(course.title)
                .font(.footnote)
                .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
            Text(course.subtitile.uppercased())
                .font(.footnote.weight(.semibold))
                .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)
            Text(course.text)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title\(course.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider() //分割线
                .opacity(apper[0] ? 1 : 0)
            HStack{
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .padding(8)
                    .background(.ultraThinMaterial, in:
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                    )
                    .strokStyle(cornerRadius: 18)
                Text("Taught by Meng to")
                    .font(.footnote)
            }
            .opacity(apper[1] ? 1 : 0)
        }
        .padding(20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
        )
        .offset(y: 200)
        .padding(20)
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged{ value in
                guard value.translation.width > 0 else {return}
                if value.startLocation.x < 100 {  //仅允许边缘滑动
                    withAnimation(.closeCard)
                    {
                        viewState = value.translation
                    }
                }
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded{ value in
                if viewState.width > 80 {
                    close()
                }
                else
                {
                    withAnimation(.closeCard){
                        viewState = .zero
                    }
                }
            }
    }
}

struct CourseView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CourseItem(namespace: namespace, show: .constant(true))
            .environmentObject(Model())
    }
}
