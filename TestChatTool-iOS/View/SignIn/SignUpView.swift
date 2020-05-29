//
//  SignUpView.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/22.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI
import AWSMobileClient

struct SignUpView: View {
    @ObservedObject var viewModel:SignUpViewModel
    @ObservedObject var keyboard = KeyboardObserver()
    var body: some View {
        VStack(alignment: .leading){
            TextField("username", text: self.$viewModel.userName)
                .padding(5.0)
                .border(Color.gray)
            TextField("mailaddres", text: self.$viewModel.mailAddres)
                .padding(5.0)
                .border(Color.gray)
            SecureField("password", text: self.$viewModel.password)
                .padding(5.0)
                .border(Color.gray)
            HStack(){
                Spacer()
                Button(action: {
                    self.viewModel.signUp()
                }){
                    Text("SignUp")
                }
            }.navigationBarTitle("SignUp")
        }
    .padding()
        .padding(.bottom,self.keyboard.keyboardHeight)
        .animation(.easeOut)
        .onAppear(){
            self.keyboard.startObserve()
        }
        .onDisappear(){
            self.keyboard.stopObserve()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
