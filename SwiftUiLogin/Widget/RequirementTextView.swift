//
//  RequirementTextView.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/24.
//

import SwiftUI

struct RequirementTextView: View {
    var validEnum: ValidEnum //傳入檢核列舉
    
    var body: some View {
        HStack {
            Image(systemName: validEnum.iconName)
                .foregroundColor(validEnum.iconColor)
            Text(validEnum.text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(validEnum.isSuccess)
            Spacer()
        }
    }
}

struct RequirementTextView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementTextView(validEnum: .passwordConfirm(valid: true))
    }
}
