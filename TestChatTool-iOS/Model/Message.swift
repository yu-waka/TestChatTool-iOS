//
//  Message.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/11.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI
import AWSAppSync

struct Message:Identifiable,Hashable{
    var id :GraphQLID
    var roomId: GraphQLID
    var message: String
    var owner: String
}
