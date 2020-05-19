//
//  ChatroomListView.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/04/28.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI

struct ChatroomListView: View {
    @ObservedObject var viewModel:ChatroomListViewModel
    var body: some View {
        VStack{
            NavigationView{
                List{
                    ForEach(viewModel.chatroomList){ x in
                        NavigationLink(destination: MessageList(roomInfo: x, viewModel: MessageListViewModel())){
                                ChatroomRow(chatroomInfo: x)
                        }
                    }
                }.navigationBarTitle("Room一覧")
            }
        }.onAppear {
            self.viewModel.fech()
        }
    }
}

struct ChatroomListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatroomListView(viewModel: ChatroomListViewModel())
    }
}
