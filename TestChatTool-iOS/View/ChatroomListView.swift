//
//  ChatroomListView.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/04/28.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI

struct ChatroomListView: View {
    var body: some View {
        List{
          ChatroomRow()
        }
    }
}

struct ChatroomListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatroomListView()
    }
}
