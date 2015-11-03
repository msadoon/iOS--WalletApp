//
//  DebitCard.swift
//  InteradWallet
//
//  Created by Mubarak Sadoon on 2015-05-26.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import Foundation

class DebitCard:Card {
    @objc var ID:Int = 0
    var balance: Float = 0.0
    @objc var type: String = "Debit Card"
    @objc var issuer: String = ""
    var firstFourNumbers:UInt32 = 0
    var secondFourNumbers: UInt32 = 0
    var thirdFourNumbers:UInt32 = 0
    var fourthFourNumbers: UInt32 = 0
    private let FROM_NUM:UInt32 = 1000
    private let TO_NUM:UInt32 = 8999
    private let MAX_CREDIT:UInt32 = 10000
    
    init(id:Int, issuingBank:String) {
        ID = id
        issuer = issuingBank
        
        //generate random balances and allowable credit for demo purposes
        balance = (Float(arc4random_uniform(100)/100) + Float(arc4random_uniform(MAX_CREDIT))+1)

        //generate random card numbers from 100-999 for demo purposes
        firstFourNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        secondFourNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        thirdFourNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        fourthFourNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
    }
    
    @objc func getBalance() -> Float {
        return balance
    }
    
    @objc func getCardNumberSet1() -> Int {
        return Int(firstFourNumbers)
    }
    
    @objc func getCardNumberSet2() -> Int {
        return Int(secondFourNumbers)
    }
    
    @objc func getCardNumberSet3() -> Int {
        return Int(thirdFourNumbers)
    }
    
    @objc func getCardNumberSet4() -> Int {
        return Int(fourthFourNumbers)
    }
    
}