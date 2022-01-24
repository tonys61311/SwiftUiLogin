//
//  ChangePwdModel.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/24.
//

import Foundation
import Combine

class ChangePwdModel: ObservableObject {
    @Published var password = ""
    @Published var passwordConfirm = ""
    
    @Published var isPasswordLengthValid = ValidEnum.passwordLength(valid: false)
    @Published var isPasswordCapitalLetter = ValidEnum.passwordCapitalLetter(valid: false)
    @Published var isPasswordConfirmValid = ValidEnum.passwordConfirm(valid: false)
    @Published var showAlert = false
    @Published var checkSuccess = false
    
    var errMsg = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        //密碼是否大於等於八碼
        $password
            .receive(on: RunLoop.main)
            .map{ password in
                let result = password.count >= 8
                return ValidEnum.passwordLength(valid: result)
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        
        //密碼是否包含大寫字母
        $password
            .receive(on: RunLoop.main)
            .map{ password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return ValidEnum.passwordCapitalLetter(valid: true)
                } else {
                  return ValidEnum.passwordCapitalLetter(valid: false)
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: RunLoop.main)
            .map { (password, passwordConfirm) in
                let result = !passwordConfirm.isEmpty && passwordConfirm == password
                return ValidEnum.passwordConfirm(valid: result)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
        
    }
    
    //回傳檢核訊息
    func getErrData() -> String {
        if errMsg != "" {
            return errMsg
        }
        var resultArr: [String] = [];
        
        if !isPasswordLengthValid.isSuccess {
            resultArr.append(isPasswordLengthValid.text)
        }
            
        if !isPasswordCapitalLetter.isSuccess {
            resultArr.append(isPasswordCapitalLetter.text)

        }
        if !isPasswordConfirmValid.isSuccess {
            resultArr.append(isPasswordConfirmValid.text)
        }

        return resultArr.joined(separator: "\n")
    }
    
    //執行檢核
    func doCheck() -> Bool {
        let passwordLength = isPasswordLengthValid.isSuccess
        let passwordCapitalLetter = isPasswordCapitalLetter.isSuccess
        let passwordConfirm = isPasswordConfirmValid.isSuccess
        if !passwordLength || !passwordCapitalLetter || !passwordConfirm {
            self.showAlert = true
            return false
        } else {
            self.checkSuccess = true
            return true
        }
    }
    
}
