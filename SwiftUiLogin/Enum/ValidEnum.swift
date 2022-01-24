//
//  ValidEnum.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/24.
//

import Foundation
import SwiftUI

enum ValidEnum {
    case passwordLength(valid: Bool)
    case passwordCapitalLetter(valid: Bool)
    case passwordConfirm(valid: Bool)
    
    var iconName: String {
        switch self {
        case .passwordLength, .passwordCapitalLetter:
            return "lock.open"
        case .passwordConfirm:
            return "xmark.square"
        }
    }
    
    var text: String {
        switch self {
        case .passwordLength:
            return "A minimum of 8 characters"
        case .passwordCapitalLetter:
            return "One uppercase letter"
        case .passwordConfirm:
            return "Your confirm password should be the same as password"
        }
    }
    
    var isSuccess: Bool {
        switch self {
        case .passwordLength(let valid):
            return valid
        case .passwordCapitalLetter(let valid):
            return valid
        case .passwordConfirm(let valid):
            return valid
        }
    }
    
    var iconColor: Color {
        return self.isSuccess ? Color.secondary : Color.red
    }
}
