//
//  CommonButton.swift
//  SwiftUiLogin
//
//  Created by 林星辰 on 2022/1/23.
//

import SwiftUI

struct CommonButton: View {
    var text: String
    var action: () -> ()
    @State private var showAlert: Bool = false
    var body: some View {
        Button (action:{self.action()}){
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.white)
                .bold()
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Your data"),
                message: Text("text"),
                dismissButton: .default(Text("OK")) {}
            )
        }
    }
}

struct CommonButton_Previews: PreviewProvider {
    static var previews: some View {
        CommonButton(text: "text") {
            
        }
    }
}
