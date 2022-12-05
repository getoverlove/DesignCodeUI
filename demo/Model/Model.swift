//
//  Model.swift
//  demo
//
//  Created by User on 2022/12/4.
//

import SwiftUI
import Combine

class Model: ObservableObject{
    @Published var showDetail: Bool = false  //用于同步数据
}
