//
//  MessageRow.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/15.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI

struct MessageRow: View {
    var userName:String
    @State var message:Message
    var body: some View {
        HStack{
            if userName == message.owner {
                Spacer()
                item
                .background(Color.init(red: 0.4, green: 0.9, blue: 0.3))
                .cornerRadius(10)
            }else{
                item
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
                .cornerRadius(10)
                Spacer()
            }
        }.padding(.horizontal)
    }
    var item:some View{
        VStack{
            HStack{
                Text(self.message.message)
                .lineLimit(nil)
                Spacer()
            }
            HStack{
                Spacer()
                Text(self.message.owner)
            }
        }
        .frame(width: 240, height: nil, alignment: .leading)
        .padding(10)
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(userName: "user", message: Message(id: "id001", roomId: "id01", message: "コメント", owner: "user01"))
    }
}

