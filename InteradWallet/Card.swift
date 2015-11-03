//
//  Card.swift
//  InteradWallet
//
//  Created by Mubarak Sadoon on 2015-05-26.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import Foundation

@objc protocol Card {
    var ID:Int { get set }
    var issuer: String { get set }
    var type: String { get set }
    
    func getBalance() -> Float
    
    func getCardNumberSet1() -> Int
    
    func getCardNumberSet2() -> Int
    
    func getCardNumberSet3() -> Int
    
    func getCardNumberSet4() -> Int
    
    optional func getCardNumberSet5() -> Int

    optional func getAllowableCredit() -> Float
    
}