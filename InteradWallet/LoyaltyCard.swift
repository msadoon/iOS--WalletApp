//
//  LoyalityCard.swift
//  InteradWallet
//
//  Created by Mubarak Sadoon on 2015-05-26.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import Foundation

class LoyaltyCard:Card {
    @objc var ID:Int = 0
    @objc var issuer: String = ""
    @objc var type: String = "Loyalty Card"
    var firstThreeNumbers:UInt32 = 0
    var secondThreeNumbers: UInt32 = 0
    var thirdThreeNumbers:UInt32 = 0
    var fourthThreeNumbers: UInt32 = 0
    var pointsRemaining: UInt32 = 0
    private let FROM_NUM:UInt32 = 100
    private let TO_NUM:UInt32 = 999
    private let MAX_POINTS:UInt32 = 100000
    private let MIN_POINTS:UInt32 = 0
    
    init(id:Int, issuingBank:String) {
        ID = id
        issuer = issuingBank
        
        //generate random balances and allowable credit for demo purposes
        pointsRemaining = arc4random_uniform(MAX_POINTS)+1
        //generate random card numbers from 100-999 for demo purposes
        firstThreeNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        secondThreeNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        thirdThreeNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        fourthThreeNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
    }
    
    @objc func getBalance() -> Float {
        return Float(pointsRemaining)
    }
    
    @objc func getCardNumberSet1() -> Int {
        return Int(firstThreeNumbers)
    }
    
    @objc func getCardNumberSet2() -> Int {
        return Int(secondThreeNumbers)
    }
    
    @objc func getCardNumberSet3() -> Int {
        return Int(thirdThreeNumbers)
    }
    
    @objc func getCardNumberSet4() -> Int {
        return Int(fourthThreeNumbers)
    }
}