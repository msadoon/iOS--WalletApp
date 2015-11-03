//
//  PostTableViewCell.swift
//  InteradWallet
//
//  Created by Mubarak Sadoon on 2015-05-21.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var LogoBottom: UIImageView!
    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var LogoTop: UIImageView!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var creditBalance: UILabel!
    @IBOutlet weak var cardTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
