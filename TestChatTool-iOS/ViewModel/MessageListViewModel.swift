//
//  MessageListViewModel.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/05/18.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import SwiftUI
import AWSAppSync
import AWSMobileClient

class MessageListViewModel: ObservableObject {
    var currentuser:String
    @Published var messageList:[Message] = []
    @Published var newMessage:String
    
    var subscriptionWatcher:Cancellable?
    var appSyncClient:AWSAppSyncClient?
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
        self.currentuser = AWSMobileClient.default().username!
        newMessage = ""
        
    }
    func fetch(roomId:String){
        let idInput =  ModelIDInput(eq: roomId)
        let filterInput = ModelmessageFilterInput(id: nil, roomId: idInput)
        
        appSyncClient?.fetch(
            query: ListMessagesQuery(filter: filterInput, limit: nil, nextToken: nil),
            cachePolicy: .returnCacheDataAndFetch,
            resultHandler: { (result, error) in
                if let error = error {
                    print("error ListChatroomsQuery:\(error.localizedDescription)")
                    return
                }
                result?.data?.listMessages?.items!.forEach({ (message) in
                    //
                    let messagetmp = Message(
                        id: message!.id,
                        roomId: message!.roomId,
                        message: (message?.message)!,
                        owner: message!.owner)
                    if let index = self.messageList.firstIndex(where: { (message) -> Bool in
                        return message.id == messagetmp.id
                    }){
                        self.messageList[index] = messagetmp
                    }else{
                        self.messageList.append(messagetmp)
                    }
                })
        })
    }
    
    func subscribe(){
        do{
            self.subscriptionWatcher = try appSyncClient?.subscribe(
                subscription: OnCreateMessageSubscription(),
                resultHandler: { (result, transaction, error) in
                    if let onCreateMessage = result?.data?.onCreateMessage {
                        let tmp = Message(
                            id: onCreateMessage.id,
                            roomId: onCreateMessage.roomId,
                            message: onCreateMessage.message!,
                            owner: onCreateMessage.owner)
                        self.messageList.append(tmp)
                    } else if let error = error {
                        print("error OnCreateMessageSubscription:\(error.localizedDescription)")
                }
            })
        }catch{
            
        }
        
    }
    func  unsubscribe(){
        self.subscriptionWatcher?.cancel()
    }
}

