//
//  AppDelegate.swift
//  TestChatTool-iOS
//
//  Created by yu-waka on 2020/04/28.
//  Copyright © 2020 yu-waka. All rights reserved.
//

import UIKit
import AWSMobileClient
import AWSAppSync

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appSyncClient:AWSAppSyncClient?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //AWSモバイルクライアントの初期化
        AWSMobileClient.default().initialize {(userState, error) in
            if let error = error {
                print("error:\(error.localizedDescription)")
                return
            }
            // todo appsyncクライアントの初期化
            //Appsyncクライアントの初期化
            do {
                //キャッシュデータベースの設定を取得
                let cacheConfiguration = try AWSAppSyncCacheConfiguration()
                //
                let appSyncServiceConfig = try AWSAppSyncServiceConfig()
                //
//                let appSyncConfig = try AWSAppSyncClientConfiguration(appSyncServiceConfig: appSyncServiceConfig,cacheConfiguration: cacheConfiguration)
                let appSyncConfig = try AWSAppSyncClientConfiguration(
                    appSyncServiceConfig:appSyncServiceConfig,
                    userPoolsAuthProvider: (AWSMobileClient.default() as! AWSCognitoUserPoolsAuthProvider),
                        cacheConfiguration: cacheConfiguration)
                
                //
                self.appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig)
            }catch{
                print("Error initializing appsync client. \(error)")
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
extension AWSMobileClient:AWSCognitoUserPoolsAuthProviderAsync{
    public func getLatestAuthToken(_ callback: @escaping (String?, Error?) -> Void) {
        getTokens { (tokens, error) in
            if let error = error {
                callback(nil,error)
            }else{
                callback(tokens?.idToken?.tokenString,nil)
            }
        }
    }
}

