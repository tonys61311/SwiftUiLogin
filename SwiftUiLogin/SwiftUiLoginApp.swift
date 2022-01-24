//
//  SwiftUiLoginApp.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/23.
//

import SwiftUI
import Firebase

@main
struct SwiftUiLoginApp: App {
    
    init() {
     FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
