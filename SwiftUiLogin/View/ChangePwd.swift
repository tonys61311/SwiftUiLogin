//
//  ChangePwd.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/23.
//

import SwiftUI
import Firebase

struct ChangePwd: View {
    var userModel: UserModel
    @ObservedObject private var pwdModel = ChangePwdModel()
    @State private var showLoading = false
    
    func doChangePwd() {
        self.showLoading = true
        Auth.auth().currentUser?.updatePassword(to: pwdModel.password) { (error) in
            
            if error != nil {
                pwdModel.showAlert = true
                pwdModel.errMsg = error?.localizedDescription ?? ""
            } else {
                self.userModel.password = self.pwdModel.password //成功更新密碼
                pwdModel.checkSuccess = true
            }
            
            self.showLoading = false
        }
    }
    
    var body: some View {
        LoadingView(isShowing: $showLoading) {
            NavigationView {
                VStack {
                    
                    VStack {
                        
                        FormField(fieldName: "New Password", value: $pwdModel.password, isSecure: true)
                        
                        RequirementTextView(validEnum: pwdModel.isPasswordLengthValid)
                        
                        RequirementTextView(validEnum: pwdModel.isPasswordCapitalLetter)
                        
                    }.padding(.bottom)
                    
                    VStack {
                        
                        FormField(fieldName: "Type Again", value: $pwdModel.passwordConfirm, isSecure: true)
                        
                        RequirementTextView(validEnum: pwdModel.isPasswordConfirmValid)
                        
                    }.padding(.bottom)
                    
                    NavigationLink(destination: LoginView(model: userModel)
                       //隱藏下頁導覽列
                       .navigationBarHidden(true),
                                   isActive: $pwdModel.checkSuccess,
                       label: {
                        CommonButton(text: "SUBMIT", action: {
                            //密碼檢核
                            let result = self.pwdModel.doCheck()
                            if result {
                                doChangePwd()
                                
                            } else {
                                self.pwdModel.checkSuccess = result
                            }
                            
                        })
                            .alert(isPresented: $pwdModel.showAlert) {
                                Alert(
                                    title: Text("Message"),
                                    message: Text(pwdModel.getErrData()),
                                    dismissButton: .default(Text("OK")) {}
                                )
                            }
                        }
                    )
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Change password")
            }
        }
    }
}

struct ChangePwd_Previews: PreviewProvider {
    static var previews: some View {
        ChangePwd(userModel: UserModel())
    }
}

