//
//  SignInViewModel.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/11.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import Foundation
import AWSMobileClient
class SignInViewModel: ObservableObject{
    @Published var userName: String = ""
    @Published var password: String = ""
    
    func signIn(){
        
        AWSMobileClient.default().signIn(
            username: userName,
            password: password) { (result, error) in
                if let error = error {
                    print("signIn error:\(error.localizedDescription)")
                }
                print("sgin in success")
        }
    }
}
