import SwiftUI

struct CustomInputField: View {
    @Binding var userInput: String
    @State private var isSecure = true
    var isRightIcon: Bool = false
    var isPassword: Bool = false
    var fieldLabelName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldLabelName)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("LabelColor"))
                .padding(.horizontal)
            
            HStack {
                if isRightIcon {
                    if isPassword {
                        if isSecure {
                            SecureField("Enter Password", text: $userInput)
                        } else {
                            TextField("Enter Password", text: $userInput)
                        }
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.primary)
                        }
                    } else {
                        TextField("Enter Email", text: $userInput)
                        Spacer() // Pushes the email icon to the right corner
                        Image(systemName: "envelope")
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
    }
}

#Preview {
    CustomInputField(userInput: .constant(""))
}
