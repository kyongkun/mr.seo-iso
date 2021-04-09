//
//  TotalCoinCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 03/03/21.
//

import UIKit

class TotalCoinCellXIB: UITableViewCell {
//    /@IBOutlet weak var ViewHead:UIView!
    @IBOutlet weak var LblInfo: UILabel!{
        didSet{
            LblInfo.text = "I have " + EstalimUser.shared.coin  + " Coins for use"
        }
    }
    @IBOutlet weak var Lblamount: UILabel!{
        didSet{
            Lblamount.text =  EstalimUser.shared.coin  + " Coins"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
