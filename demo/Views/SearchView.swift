//
//  SearchView.swift
//  demo
//
//  Created by User on 2022/12/5.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var show = false
    @Namespace var namespace
    @State var selectedIndex = 0
    @Environment(\.presentationMode) var presentationMode  //用于sheet跳转过来后再取消
    var body: some View {
        NavigationView {
            //方式1 使用list
            //            List {
            //                content
            //            }
            //方式2 使用Scroll, 可以自定义
            ScrollView{
                VStack{
                    content
                }
                .padding(20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .strokStyle(cornerRadius: 30)
                .padding(.horizontal,20)
                .background(  //用于让搜索栏字体可见
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(height: 200)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .blur(radius: 20)
                        .offset(y: -150)
                )
                .background(
                    Image("Blob 1").offset(x: -100, y: -150)
                )
            }
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("sui, React, other"))  // $用于绑定
            {
                //用于点击搜索栏后显示建议
                ForEach(suggestion) { suggestion in
                    Button{
                        text = suggestion.text  //
                    } label: {
                        Text(suggestion.text)
                            .searchCompletion(suggestion.text)  //填充
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            
            //增加一个Done按钮用于关闭搜索列表
            .navigationBarItems(trailing: Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done").bold()
            })
            .sheet(isPresented: $show) {
                CourseView(namespace: namespace, course: courses[selectedIndex], show: $show)
            }
        }
    }
    
    var content: some View{
        ForEach(Array(courses.enumerated()), id: \.offset) //??
        { index, item in
            if item.title.contains(text) || text == "" { //或者什么都没填，显示所有
                if index != 0
                {
                    Divider()
                }
                Button{
                    show = true
                    selectedIndex = index
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .background(Color("Backgroud"))
                            .mask(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title).bold()
                                .foregroundColor(.primary)
                            Text(item.text)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading) //多行文字对齐3
                            
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 15)
                .listRowSeparator(.hidden)
            }
            }
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
