//
//  RoomInfo.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/11.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI
import AWSAppSync

struct RoomInfo:Identifiable,Hashable{
    var id : String
    var roomName: String
    var ownerName: String
}
