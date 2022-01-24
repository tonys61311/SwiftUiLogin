//
//  LoginSuccess.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/23.
//

import SwiftUI

struct LoginSuccess: View {
    var model: UserModel
    @State private var gotoChangePwd = false
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: ChangePwd(userModel: model)
                   //隱藏下頁導覽列
                   .navigationBarHidden(true),
                    isActive: $gotoChangePwd,
                   label: {
                    CommonButton(text: "CHANGE PASSWORD", action: {self.gotoChangePwd = true})
                    }
                )
                
                Spacer()
            }
            .padding()
            .navigationTitle("Hello, \(model.email)")
        }
    }
}

struct LoginSuccess_Previews: PreviewProvider {
    static var previews: some View {
        LoginSuccess(model: UserModel())
    }
}
