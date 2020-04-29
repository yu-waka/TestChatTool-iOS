//
//  ChatroomRow.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/04/28.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI

struct ChatroomRow: View {
    var body: some View {
        VStack(alignment:.leading){
            Text("ChatroomName")
            Text("owner")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all, 5.0)
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(10)
            .padding(.horizontal, 10.0)
    }
}

struct ChatroomRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatroomRow()
    }
}
