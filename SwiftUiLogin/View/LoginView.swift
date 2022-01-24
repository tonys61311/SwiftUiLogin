//
//  ContentView.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @ObservedObject var model: UserModel = UserModel()
    @State private var loginSuccess = false
    @State private var showLoading = false
    
    
    func login() {
        self.showLoading = true
        Auth.auth().signIn(withEmail: model.email, password: model.password) { result, error in
            
            if error != nil {
                model.showAlert = true
                model.errMsg = error?.localizedDescription ?? ""
            } else {
                loginSuccess = true
            }
            
            self.showLoading = false
        }
    }
    
    var body: some View {
        LoadingView(isShowing: $showLoading) {
            NavigationView {
                VStack {
    //                Text("Log in")
    //                    .font(.system(.largeTitle, design: .rounded))
    //                    .bold()
                    
                    FormField(fieldName: "Email", value: $model.email)
                        .padding(.bottom)
                    
                    FormField(fieldName: "Password", value: $model.password, isSecure: true)
                        .padding(.bottom)
                    
                    NavigationLink(destination: LoginSuccess(model: model)
                       //隱藏下頁導覽列
    //                   .navigationBarTitle("")
                       .navigationBarHidden(true),
                       isActive: $loginSuccess,
                       label: {
                            CommonButton(text: "LOG IN", action: login)
                            .alert(isPresented: $model.showAlert) {
                                Alert(
                                    title: Text("Message"),
                                    message: Text(model.errMsg),
                                    dismissButton: .default(Text("OK")) {}
                                )
                            }
                        }
                    )
                    
                    
                    
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Log in")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
