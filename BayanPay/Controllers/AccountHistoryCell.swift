//
//  AccountHistoryCell.swift
//  BayanPay
//
//  Created by Mohanad on 1/31/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class AccountHistoryCell: UITableViewCell {
    
    @IBOutlet weak var IPAddress: UILabel!
    @IBOutlet weak var Upload: UILabel!
    @IBOutlet weak var Download: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Speed: UILabel!
    @IBOutlet weak var AccDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
