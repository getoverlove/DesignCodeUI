//
//  FeaturedItem.swift
//  demo
//
//  Created by User on 2022/11/26.
//

import SwiftUI

struct FeaturedItem: View {
    var course: Course = courses[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            HStack {
                Image(course.logo)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: /*@START_MENU_TOKEN@*/26.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/26.0/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20)
                    .padding(9)
                    .background(.ultraThinMaterial, in:
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                    )
                    .strokStyle(cornerRadius: 16)
            }
            Text(course.title)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .top, endPoint: .bottomTrailing))
            Text(course.subtitile.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Text(course.text)
                .font(.footnote)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
            
        }
        .padding(23.0)
        .frame(height: 350.0)
        .background(.ultraThinMaterial, in:
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
        )
        //            .cornerRadius(30)
        //            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        
        .strokStyle()
        .padding(.horizontal,20)
        
//        .overlay(Image(course.image)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(height: 230)
//            .offset(x: 32,y:-80)
//    )
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItem()
    }
}
