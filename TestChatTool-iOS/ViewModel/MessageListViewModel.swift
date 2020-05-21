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
    
    func subscribe(roomId:String){
        do{
            self.subscriptionWatcher = try appSyncClient?.subscribe(
                subscription: OnCreateMessageByRoomIdSubscription(roomId: roomId),
                resultHandler: { (result, transaction, error) in
                    if let result = result?.data?.onCreateMessageByRoomId {
                        let tmp = Message(
                            id: result.id,
                            roomId: result.roomId,
                            message: result.message!,
                            owner: result.owner)
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
    func sendMessage(roomId:String){
        let userName = AWSMobileClient.default().username!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let datetime = formatter.string(from: Date())
        let id = datetime + userName
        let input = CreateMessageInput(id: id, roomId: roomId, message: self.newMessage, owner: userName)
        appSyncClient?.perform(mutation: CreateMessageMutation(input: input))
    }
}

