import SwiftUI

struct CustomInputField: View {
    @Binding var userInput: String
    @State private var isSecure = true
    var isRightIcon: Bool = false
    var isPassword: Bool = false
    var fieldLabelName: String = ""
    var placeHolderText: String
    var errorText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldLabelName)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(!errorText.isEmpty ? .red : .labelText)
                .padding(.horizontal)
            
            HStack {
                if isRightIcon {
                    if isPassword {
                        if isSecure {
                            SecureField(placeHolderText, text: $userInput)
                        } else {
                            TextField(placeHolderText, text: $userInput)
                        }
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.primary)
                        }
                    } else {
                        TextField(placeHolderText, text: $userInput)
                        Spacer() // Pushes the email icon to the right corner
                        Image(systemName: "envelope")
                            .foregroundColor(.primary)
                    }
                } else {
                    TextField(placeHolderText, text: $userInput)
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(!errorText.isEmpty ? .red : .gray)
               
            Text("\(errorText)")
                .foregroundStyle(.red)
                .border(Color.black)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)

        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomInputField(userInput: .constant(""), placeHolderText: "")
}
