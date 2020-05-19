//
//  ChatroomListViewModel.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/11.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI
import AWSAppSync

class ChatroomListViewModel: ObservableObject {
    @Published var chatroomList:[RoomInfo] = []

    var appSyncClient: AWSAppSyncClient?
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
    }
    func fech(){
        appSyncClient?.fetch(
            query: ListChatroomsQuery(),
            cachePolicy: .returnCacheDataAndFetch,
            resultHandler: { (result, error) in
            if let error = error {
                print("error ListChatroomsQuery:\(error.localizedDescription)")
                return
            }
                result?.data?.listChatrooms?.items!.forEach({ (roomInfo) in
                    let roomInfotmp = RoomInfo(id: (roomInfo?.id)!, roomName: (roomInfo?.name)!, ownerName: roomInfo!.owner)
                    if let index = self.chatroomList.firstIndex(where: { (room) -> Bool in
                        return room.id == roomInfotmp.id
                    }){
                        self.chatroomList[index] = roomInfotmp
                    }else{
                        self.chatroomList.append(roomInfotmp)
                    }
                })
        })
    }
}
