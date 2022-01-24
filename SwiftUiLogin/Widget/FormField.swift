//
//  FormField.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/23.
//

import SwiftUI

struct FormField: View {
    var fieldName = ""
    @Binding var value: String
    var isSecure = false
    
    
    var fieldView: some View {
        Group{
            if isSecure {
                SecureField(fieldName, text: $value)
            }else{
                TextField(fieldName, text: $value)
            }
        }
    }
    
    var body: some View {
        VStack {
            fieldView
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .stroke(Color.black, lineWidth: 3)
                        )
        }
    }
}
