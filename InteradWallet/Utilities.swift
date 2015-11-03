//
//  Utilities.swift
//  InteradWallet
//
//  Created by Mubarak Sadoon on 2015-05-21.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import Foundation
import UIKit

public class Utilities {
    static var utilitiesInstance = Utilities.init()
    private var mainAppColor = UIColor(red: 107.0/255.0, green: 112.0/255.0, blue: 125.0/255.0, alpha: 1)
    private var centerPoint:CGPoint = CGPointMake(50.0,50.0)
    private var cardArrayForDemoPurposes:[Card] = []
    
    init() {
       //this is a Singleton class used for common functions
    }

    func setGiftCardArrayForDemoPurposes() {
        let gc1:Card = GiftCard(id: 1, issuingBank:"Chapters")
        let gc2:Card = GiftCard(id: 2, issuingBank:"Tim Horton's")
        let gc3:Card = GiftCard(id: 3, issuingBank:"Second Cup")
        let gc4:Card = GiftCard(id: 4, issuingBank:"iTunes")
        let gc5:Card = GiftCard(id: 5, issuingBank:"Canada Computers")
        cardArrayForDemoPurposes = [gc1,gc2,gc3,gc4,gc5]
    }
    
    func setLoyaltyCardsForDemoPurposes() {
        let lc1:Card = LoyaltyCard(id: 1, issuingBank:"Canadian Tire")
        let lc2:Card = LoyaltyCard(id: 2, issuingBank:"Walmart")
        let lc3:Card = LoyaltyCard(id: 3, issuingBank:"Home Depot")
        let lc4:Card = LoyaltyCard(id: 4, issuingBank:"Cineplex")
        let lc5:Card = LoyaltyCard(id: 5, issuingBank:"Starbucks")
        cardArrayForDemoPurposes = [lc1,lc2,lc3,lc4,lc5]
    }
    
    func setBankingArrayForDemoPurposes() {
        let cc1:Card = CreditCard(id: 1, issuingBank:"RBC")
        let cc2:Card = CreditCard(id: 2, issuingBank:"Scotiabank")
        let dc1:Card = DebitCard(id: 3, issuingBank:"Scotiabank")
        let cc3:Card = CreditCard(id: 4, issuingBank:"TD Canada Trust")
        let dc2:Card = DebitCard(id: 5, issuingBank:"RBC")
        cardArrayForDemoPurposes = [cc1,cc2,dc1,cc3,dc2]
    }
    
    func secureNumberSet(int:Int)-> String {
        //I don't actually secure it, but in theory this is where it would happen
        return "***"
    }
    
    func swapTwoValuesInDemoArray(first:Int, withSecond:Int) {
        swap(&cardArrayForDemoPurposes[first], &cardArrayForDemoPurposes[withSecond])
    }
    
    func getArrayForDemoPurposes() -> NSArray {
        return cardArrayForDemoPurposes
    }
    
    public func getAppColor()->UIColor
    {
        return mainAppColor
    }
    
    public func getScreenWidth() -> Float
    {
        return Float(UIScreen.mainScreen().bounds.width)
    }
    
    public func getScreenHeight() -> Float
    {
        return Float(UIScreen.mainScreen().bounds.height)
    }
    
    public func getStatusBarHeight() -> Float
    {
        return Float(UIApplication.sharedApplication().statusBarFrame.height)
    }
    
    public func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}