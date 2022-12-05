//
//  Course.swift
//  demo
//
//  Created by User on 2022/11/26.
//

import SwiftUI

struct Course: Identifiable {
    let id = UUID()
    var title: String
    var subtitile: String
    var text: String
    var image: String
    var background: String
    var logo: String
}

var featuredCourses = [
    Course(title: "sui a i15", subtitile: "20 - 33", text: "Build a i app", image: "Illustration 5", background: "Background 1", logo: "Logo 2"),
    Course(title: "ui b i15", subtitile: "20 - 33", text: "Build a i app", image: "Illustration 3", background: "Background 2", logo: "Logo 4"),
    Course(title: "flutter c i15", subtitile: "20 - 33", text: "Build a i app", image: "Illustration 1", background: "Background 3", logo: "Logo 1"),
    Course(title: "react f i15", subtitile: "20 - 33", text: "Build a i app", image: "Illustration 2", background: "Background 4", logo: "Logo 3")
]
var courses = [
    Course(title: "sui a i15", subtitile: "20 - 33", text: "Build a i app", image: "Illustration 5", background: "Background 1", logo: "Logo 2"),
    Course(title: "ui b i15", subtitile: "20 - 33", text: "Build a i app", image: "Illustration 3", background: "Background 2", logo: "Logo 4"),
    Course(title: "flutter c i15", subtitile: "20 - 33", text: "Build a i app", image: "Illustration 1", background: "Background 3", logo: "Logo 1"),
    Course(title: "react f i15", subtitile: "20 - 33", text: "Build a i app", image: "Illustration 2", background: "Background 4", logo: "Logo 3")
]
