//
//  Post.swift
//  InteradWallet
//
//  Created by Mubarak Sadoon on 2015-05-21.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import Foundation

class CreditCard:Card {
    @objc var ID: Int = 0
    @objc var issuer: String = ""
    @objc var type: String = "Credit Card"
    var balance: Float = 0.0
    var totalAllowedCredit: Float = 0.0
    var firstThreeNumbers:UInt32 = 0
    var secondThreeNumbers: UInt32 = 0
    var thirdThreeNumbers:UInt32 = 0
    var fourthThreeNumbers: UInt32 = 0
    var fifthFourNumbers: UInt32 = 0
    private let FROM_NUM:UInt32 = 100
    private let TO_NUM:UInt32 = 899
    private let FIFTH_SET_FROM_NUM:UInt32 = 1000
    private let FIFTH_SET_TO_NUM:UInt32 = 8999
    private let MAX_CREDIT:UInt32 = 10000
    
    init(id:Int, issuingBank:String) {
        ID = id
        issuer = issuingBank
        
        //generate random balances and allowable credit for demo purposes
        while (true) {
            balance = (Float(arc4random_uniform(100)/100) + Float(arc4random_uniform(MAX_CREDIT))+1)
            if (balance < totalAllowedCredit) {
                break
            } else {
                calculateAllowedCredit()
            }
        }
        
        //generate random card numbers from 100-999 for demo purposes
        firstThreeNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        secondThreeNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        thirdThreeNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        fourthThreeNumbers = arc4random_uniform(TO_NUM) + FROM_NUM
        fifthFourNumbers = arc4random_uniform(FIFTH_SET_TO_NUM) + FIFTH_SET_FROM_NUM
    }
    
    private func calculateAllowedCredit() {
        totalAllowedCredit = (Float(arc4random_uniform(100)/100) + Float(arc4random_uniform(MAX_CREDIT))+1)
    }
    
    @objc func getBalance() -> Float {
        return balance
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
    
    @objc func getCardNumberSet5() -> Int {
        return Int(fifthFourNumbers)
    }
    
    @objc func getAllowableCredit() -> Float {
        return totalAllowedCredit
    }

}