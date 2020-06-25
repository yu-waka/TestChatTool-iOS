//
//  ConfilmSignUpViewModel.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/29.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import Foundation

class ConfilmSignUpViewModel: ObservableObject{
    @Published var userName:String = ""
    @Published var confilmCode:String = ""
}
