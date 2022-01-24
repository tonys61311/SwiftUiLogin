//
//  UserModel.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/23.
//

import Foundation
import Combine

class UserModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showAlert = false
    var errMsg = ""
    
}
