//
//  SignUpViewModel.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/22.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import Foundation
import AWSMobileClient

class SignUpViewModel: ObservableObject {
    @Published var userName:String = ""
    @Published var mailAddres:String = ""
    @Published var password:String = ""
    
    @Published var isNeedConfirmed:Bool = false
    
    func signUp(){
        let userAttributes = ["email":self.mailAddres]
        AWSMobileClient.default().signUp(
            username: self.userName,
            password: self.password,
            userAttributes: userAttributes) {
                (result, error) in
                if let result = result {
                    //サインアップ結果の確認
                    switch result.signUpConfirmationState {
                        
                    case .confirmed:
                        print("signUp result:confirmed")
                    case .unconfirmed:
                        self.isNeedConfirmed = true
                        print("signUp result:unconfirmed")
                    case .unknown:
                        print("signUp result:unknown")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                }
        }
    }
}
