//
//  AllPostsViewController.swift
//  InteradWallet
//
//  Created by Mubarak Sadoon on 2015-05-21.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class AllCardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    var utilityInstance:Utilities = Utilities.utilitiesInstance
    var buttonWidth:CGFloat?
    var underline:UIView?
    var topTabBar:UIView?
    var mainTable:UITableView?
    var menuButton:UIButton?
    var tableResize:Bool = false
    var paymentCardButton:UIButton?
    var giftCardButton:UIButton?
    var loyaltyCardButton:UIButton?
    var longpress:UILongPressGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureNavigationBar()
        setupSegmentButtons()
        setupUnderline()
        setupTableDatasource()
        setupTableView()
        setupLongPress()
    }
    
    override func viewWillAppear(animated: Bool) {
        mainTable?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI Methods
    func configureNavigationBar() {
        //get rid of shadow in navigationbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //set this up for underline and segment buttonsr
        buttonWidth = CGFloat(utilityInstance.getScreenWidth()/3)
        
        //left navigation bar button item
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        let menuButton:UIButton = UIButton(frame: CGRectMake(0, 0, 30.0, 30.0))
        menuButton.addTarget(self, action: "goToMenu", forControlEvents: UIControlEvents.TouchUpInside)
        menuButton.setBackgroundImage(UIImage(named: "menu"), forState: UIControlState.Normal)
        menuButton.setBackgroundImage(UIImage(named: "menu"), forState: UIControlState.Selected)
        menuButton.setBackgroundImage(UIImage(named: "menu"), forState: UIControlState.Highlighted)
        let newBarItemMenuButton:UIBarButtonItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = newBarItemMenuButton
        //right navigation bar button item
        let settingsButton:UIButton = UIButton(frame: CGRectMake(15, 0, 15.0, 30.0))
        settingsButton.addTarget(self, action: "goToSettings", forControlEvents: UIControlEvents.TouchUpInside)
        settingsButton.setBackgroundImage(UIImage(named: "settings"), forState: UIControlState.Normal)
        settingsButton.setBackgroundImage(UIImage(named: "settings"), forState: UIControlState.Selected)
        settingsButton.setBackgroundImage(UIImage(named: "settings"), forState: UIControlState.Highlighted)
        let newBarItemSettingsButton:UIBarButtonItem = UIBarButtonItem(customView: settingsButton)
        self.navigationItem.rightBarButtonItem = newBarItemSettingsButton
        
        //custom titleview

            //add a UILabel to update text from server every 3 seconds
            let userName:UILabel = UILabel(frame: CGRectMake(21, 0, 170, 34))
            userName.text = "John's Wallet"
            userName.textAlignment = NSTextAlignment.Left
            userName.textColor = UIColor.whiteColor()
        
        self.navigationItem.titleView = userName
    }

    
    func setupSegmentButtons() {
        
        topTabBar = UIView(frame: CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), 44))
        
        paymentCardButton = UIButton(frame: CGRectMake(0, 0, buttonWidth!, 44))
        giftCardButton = UIButton(frame:CGRectMake(buttonWidth!+paymentCardButton!.frame.origin.x, 0, buttonWidth!, 44))
        loyaltyCardButton = UIButton(frame:CGRectMake(buttonWidth!+giftCardButton!.frame.origin.x, 0, buttonWidth!, 44))
        
        paymentCardButton!.backgroundColor = UIColor(red: 161.0/255.0, green: 164.0/255.0, blue: 170.0/255.0, alpha: 1)
        giftCardButton!.backgroundColor = UIColor(red: 161.0/255.0, green: 164.0/255.0, blue: 170.0/255.0, alpha: 1)
        loyaltyCardButton!.backgroundColor = UIColor(red: 161.0/255.0, green: 164.0/255.0, blue: 170.0/255.0, alpha: 1)
        
        resetLabelTitles(paymentCardButton!, giftCards: giftCardButton!, loyaltyCards: loyaltyCardButton!)
        highlightCurrentText(paymentCardButton!)
        
        paymentCardButton!.addTarget(self, action: "paymentCards", forControlEvents: UIControlEvents.TouchUpInside)
        giftCardButton!.addTarget(self, action: "giftCards", forControlEvents: UIControlEvents.TouchUpInside)
        loyaltyCardButton!.addTarget(self, action: "loyaltyCards", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.topTabBar?.addSubview(paymentCardButton!)
        self.topTabBar?.addSubview(loyaltyCardButton!)
        self.topTabBar?.addSubview(giftCardButton!)
        self.view.addSubview(topTabBar!)
    }
    
    func resetLabelTitles(paymentCards:UIButton, giftCards:UIButton, loyaltyCards:UIButton) {
        
        var attributedTitle:NSAttributedString = NSAttributedString(string: "Payment Cards", attributes:
            [NSFontAttributeName:UIFont(name: "Arial", size: 13.0)!,
                NSForegroundColorAttributeName:utilityInstance.UIColorFromRGB(0xD4D5D8)])
        paymentCards.setAttributedTitle(attributedTitle, forState: UIControlState.Normal)
        attributedTitle = NSAttributedString(string: "Gift Cards", attributes:
            [NSFontAttributeName:UIFont(name: "Arial", size: 13.0)!,
                NSForegroundColorAttributeName:utilityInstance.UIColorFromRGB(0xD4D5D8)])
        giftCards.setAttributedTitle(attributedTitle, forState: UIControlState.Normal)
        attributedTitle = NSAttributedString(string: "Loyalty Cards", attributes:
            [NSFontAttributeName:UIFont(name: "Arial", size: 13.0)!,
                NSForegroundColorAttributeName:utilityInstance.UIColorFromRGB(0xD4D5D8)])
        loyaltyCards.setAttributedTitle(attributedTitle, forState: UIControlState.Normal)

    }
    
    func highlightCurrentText(currentButton:UIButton) {
        let attributedTitle:NSAttributedString = NSAttributedString(string: currentButton.titleLabel!.text!, attributes:
            [NSFontAttributeName:UIFont(name: "Arial", size: 13.0)!,
                NSForegroundColorAttributeName:UIColor.whiteColor()])
        currentButton.setAttributedTitle(attributedTitle, forState: UIControlState.Normal)
    }
    
    
    func setupUnderline() {
        underline = UIView(frame:CGRectMake(0,39, buttonWidth!,5))
        underline!.backgroundColor = utilityInstance.getAppColor()
        self.view.addSubview(underline!)
    }
    
    func setupTableView() {
        let navbarHeight = self.navigationController?.navigationBar.bounds.height as CGFloat!
        mainTable = UITableView(frame: CGRectMake(CGFloat(0), CGFloat(44), CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-(navbarHeight+topTabBar!.frame.size.height+20)))//20 pixels I cannot account for
        mainTable!.delegate = self
        mainTable!.dataSource = self
        mainTable!.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        let nib = UINib(nibName: "CardTableViewCell", bundle: nil)
        mainTable!.registerNib(nib, forCellReuseIdentifier: "cardCell")
        mainTable!.backgroundColor = UIColor.whiteColor()
        mainTable!.separatorColor = UIColor.clearColor()
        mainTable!.separatorInset = UIEdgeInsetsZero
        self.view.addSubview(mainTable!)
    }
    
    func setupTableDatasource() {
        utilityInstance.setBankingArrayForDemoPurposes()
    }
    
    func setupLongPress() {
         longpress = UILongPressGestureRecognizer(target: self, action: "moveTableRow:")
         mainTable!.addGestureRecognizer(longpress!)
    }
    
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let newCell:CardTableViewCell = mainTable?.dequeueReusableCellWithIdentifier("cardCell") as! CardTableViewCell
        // configure drop shadow
        
        newCell.containerView.backgroundColor = utilityInstance.UIColorFromRGB(0xF6F6F6)
        
        newCell.containerView.layer.cornerRadius = 15
        newCell.containerView.layer.borderColor = UIColor.lightGrayColor().CGColor
        newCell.containerView.layer.borderWidth = 1.5
        newCell.containerView.clipsToBounds = true
//        newCell.containerView.layer.shadowOffset = CGSizeMake(2, 2)
//        newCell.containerView.layer.shadowColor = UIColor.blackColor().CGColor
//        newCell.containerView.layer.shadowRadius = 3
//        newCell.containerView.layer.shadowOpacity = 0.80
        
        let tempCard:Card = utilityInstance.getArrayForDemoPurposes()[indexPath.row] as! Card
        
        return assignCardToCell(tempCard, newCell: newCell)
    }
    
    func assignCardToCell(card:Card, newCell:CardTableViewCell) -> CardTableViewCell{
        
        let numberFormatter:NSNumberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let amountAsString:NSString = numberFormatter.stringFromNumber(card.getBalance())!
        
        if (card.type == "Credit Card") {
            let creditBalanceAsString:NSString = numberFormatter.stringFromNumber(card.getAllowableCredit!())!
            newCell.cardTitle.text = "Credit Card"
            newCell.amountLabel.text = amountAsString as String
            newCell.cardNumberLabel.text = "\(card.getCardNumberSet1()) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet2())) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet3())) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet4())) \(card.getCardNumberSet5!())"
            newCell.creditBalance.text = creditBalanceAsString as String
            newCell.creditBalance.hidden = false
            newCell.creditLabel.hidden = false
        } else if (card.type == "Debit Card"){
            newCell.cardTitle.text = "Debit Card"
            newCell.amountLabel.text = amountAsString as String
            newCell.cardNumberLabel.text = "\(self.utilityInstance.secureNumberSet(card.getCardNumberSet1())) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet2())) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet3())) \(card.getCardNumberSet4())"
            newCell.creditBalance.hidden = true
            newCell.creditLabel.hidden = true
        } else if (card.type == "Gift Card") {
            newCell.cardTitle.text = card.issuer + " Gift Card"
            newCell.amountLabel.text = String(stringInterpolationSegment: Int(card.getBalance()))
            newCell.cardNumberLabel.text = "\(self.utilityInstance.secureNumberSet(card.getCardNumberSet1())) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet2())) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet3())) \(card.getCardNumberSet4())"
            newCell.creditBalance.hidden = true
            newCell.creditLabel.hidden = true
        } else {
            newCell.cardTitle.text = card.issuer + " Loyality Card"
            newCell.amountLabel.text = String(stringInterpolationSegment: Int(card.getBalance()))
            newCell.cardNumberLabel.text = "\(self.utilityInstance.secureNumberSet(card.getCardNumberSet1())) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet2())) \(self.utilityInstance.secureNumberSet(card.getCardNumberSet3())) \(card.getCardNumberSet4())"
            newCell.creditBalance.hidden = true
            newCell.creditLabel.hidden = true
        }
        
        
        return newCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilityInstance.getArrayForDemoPurposes().count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    //MARK: IBActions or target actions
    
    //LongPressGestureRecognizedFunction
    func moveTableRow(gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.locationInView(mainTable!)
        let indexPath = mainTable!.indexPathForRowAtPoint(locationInView)
        
        struct Snapshot {
            static var cellSnapshot : UIView? = nil
        }
        
        struct Path {
            static var initialIndexPath : NSIndexPath? = nil
        }
        
        switch state {
        case UIGestureRecognizerState.Began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = mainTable!.cellForRowAtIndexPath(indexPath!) as! CardTableViewCell
                Snapshot.cellSnapshot = snapshotOfCell(cell)
                var center = cell.center
                
                Snapshot.cellSnapshot!.center = center
                Snapshot.cellSnapshot!.alpha = 0.0
                
                mainTable!.addSubview(Snapshot.cellSnapshot!)
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    center.y = locationInView.y
                    Snapshot.cellSnapshot!.center = center
                    Snapshot.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    Snapshot.cellSnapshot!.alpha = 0.98
                    cell.alpha = 0.0
                    }, completion: { (finished) -> Void in
                        if finished {
                            cell.hidden = true
                        }
                })
            }
        case UIGestureRecognizerState.Changed:
            var center = Snapshot.cellSnapshot!.center
            center.y = locationInView.y
            Snapshot.cellSnapshot!.center = center
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                utilityInstance.swapTwoValuesInDemoArray(indexPath!.row,withSecond: Path.initialIndexPath!.row)
                mainTable!.moveRowAtIndexPath(Path.initialIndexPath!, toIndexPath: indexPath!)
                Path.initialIndexPath = indexPath
            }
        default:
            let cell = mainTable!.cellForRowAtIndexPath(Path.initialIndexPath!) as! CardTableViewCell
            cell.hidden = false
            cell.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                Snapshot.cellSnapshot!.center = cell.center
                Snapshot.cellSnapshot!.transform = CGAffineTransformIdentity
                Snapshot.cellSnapshot!.alpha = 0.0
                cell.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        Snapshot.cellSnapshot!.removeFromSuperview()
                        Snapshot.cellSnapshot = nil
                    }
                    
            })
        }
    }
    
    //longpress helper function
    func snapshotOfCell(inputView: UIView) -> UIView{
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        let cellSnapshot :UIView = UIImageView(image: image)
        
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        
        return cellSnapshot
    }
    
    func paymentCards() {
        print("Payment Cards")
        utilityInstance.setBankingArrayForDemoPurposes()
        mainTable!.reloadData()
        UIView.transitionWithView(self.underline!,
            duration: 0.3,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.resetLabelTitles(self.paymentCardButton!, giftCards: self.giftCardButton!, loyaltyCards: self.loyaltyCardButton!)
                self.highlightCurrentText(self.paymentCardButton!)
                self.underline?.frame = CGRectMake(0, 39, self.buttonWidth!, 5)},
            completion: nil)
    }
    
    func giftCards() {
        print("Gift Cards")
        utilityInstance.setGiftCardArrayForDemoPurposes()
        mainTable!.reloadData()
        UIView.transitionWithView(self.underline!,
            duration: 0.3,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.resetLabelTitles(self.paymentCardButton!, giftCards: self.giftCardButton!, loyaltyCards: self.loyaltyCardButton!)
                self.highlightCurrentText(self.giftCardButton!)
                self.underline?.frame = CGRectMake(self.buttonWidth!, 39, self.buttonWidth!, 5)},
            completion: nil)
    }
    
    func loyaltyCards() {
        print("Loyalty Cards")
        utilityInstance.setLoyaltyCardsForDemoPurposes()
        mainTable!.reloadData()
        UIView.transitionWithView(self.underline!,
            duration: 0.3,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.resetLabelTitles(self.paymentCardButton!, giftCards: self.giftCardButton!, loyaltyCards: self.loyaltyCardButton!)
                self.highlightCurrentText(self.loyaltyCardButton!)
                self.underline?.frame = CGRectMake(self.buttonWidth!*2, 39, self.buttonWidth!, 5)},
            completion: nil)
    }
    
    
    func goToMenu() {
        print("menu")
    }
    
    func goToSettings() {
        print("settings")
    }
    
}