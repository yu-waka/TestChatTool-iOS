//
//  MessageList.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/14.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI

struct MessageList: View {
    @State var roomInfo : RoomInfo
    
    @ObservedObject var keyboard = KeyboardObserver()
    @ObservedObject var viewModel:MessageListViewModel
    var body: some View {
        VStack{
                List{
                    ForEach(viewModel.messageList.sorted(by: { (message1:Message, message2:Message) -> Bool in
                        return message1.id < message2.id
                    })){ message in
                        MessageRow(userName: self.viewModel.currentuser, message: message)
                    }
                }
                HStack{
                    TextField("メッセージを入力してください", text:$viewModel.newMessage)
                        .lineLimit(nil)
                    Button(action: {
                        if self.viewModel.newMessage == "" {
                            return
                        }
                    }) {
                        Text("送信")
                    }
                }.padding()
                    .navigationBarTitle(roomInfo.roomName)
        }.onAppear(){
            self.viewModel.fetch(roomId: self.roomInfo.id)
            self.viewModel.subscribe()
            self.keyboard.startObserve()
        }.onDisappear(){
            self.viewModel.unsubscribe()
            self.keyboard.stopObserve()
        }.padding(.bottom, self.keyboard.keyboardHeight)
            .animation(.easeOut)
        
    }
}

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        MessageList(roomInfo: RoomInfo(id: "i001", roomName: "Test", ownerName: "Test"), viewModel: MessageListViewModel())
    }
}
