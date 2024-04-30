//
//  CustomInputFeild.swift
//  SwiftUIProject
//
//  Created by Mani Sankar on 01/05/24.
//

import SwiftUI

struct CustomInputField: View {
    
    @Binding var userInput: String
    @State private var isSecure = true
    var isRightIcon: Bool = false
    var isPassword: Bool = false
    var body: some View {
        Text("Email")
         
    }
}

#Preview {
    CustomInputField(userInput: .constant(""))
}
