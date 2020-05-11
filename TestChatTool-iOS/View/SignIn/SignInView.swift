//
//  SignInView.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/04.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel:SignInViewModel
    var body: some View {
        VStack(alignment: .leading){
            Text("SignIn")
            TextField("username", text: $viewModel.userName)
                .autocapitalization(.none)
                .padding(.all, 5.0)
                .border(Color.gray)
            SecureField("password", text: $viewModel.password)
                .padding(.all, 5.0)
                .cornerRadius(10)
                .border(Color.gray)

            HStack(){
                Spacer()
                Button(action: {
                    //サインイン処理の実行
                    self.viewModel.signIn()
                }) {
                    Text("SignIn")
                }
                .padding(.all, 5.0)
            }
        }.padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}
