//
//  AppDelegate.swift
//  CryptoDemo
//
//  Created by 梁泽 on 2019/8/28.
//  Copyright © 2019 梁泽. All rights reserved.
//

import UIKit
import CryptoSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let ecc = GMEllipticCurveCrypto.generateKeyPair(for: GMEllipticCurve(256))!
        let key = ecc.sharedSecret(forPublicKeyBase64: "A5ueV/0VH6vc8JTeAI3HsLlI9/LwQJ/tDhpESBwTJNJv")!.bytes
        
        let message = #"{"requestBody":{"code":"081IkUZ21CMLWP1dppZ21b84031IkUZM"},"requestHeader":{"requestSequence":"372B0F47FB0F40AD8ED409EA28EB0F91","requestDate":"20190827","requestTime":"110638"}}"#
                
        let iv = "7K9u97Pd".data(using: .utf8)!.bytes
        
        let msg = message.bytes
        let chacha = try! ChaCha20(key: key, iv: iv)
        
        let encrypted = try! chacha.encrypt(msg)
        let str = encrypted.toBase64()!
        print("加密后字符串是: \(str)")
        
        
        //解密
        let dec1 = try! ChaCha20(key: key, iv: iv).decrypt(Array<UInt8>(base64: str))
        let dec1Str = String(bytes: Data(dec1), encoding: .utf8)!
        print("解密后字符串是: \(dec1Str)")
        
        
        return true
    }
    
 

}

