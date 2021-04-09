//
//  CoinsCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 03/03/21.
//

import UIKit

class CoinsCellXIB: UITableViewCell {

    @IBOutlet weak var LblInfo: UILabel!
    @IBOutlet weak var LblDate: UILabel!
    @IBOutlet weak var Lblamount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        if(Bool.random() == true){
//            self.Lblamount.textColor = hexStringToUIColor(hex:"FF0000")
//            self.Lblamount.text = "Used"
//        }
//        else{
//            self.Lblamount.text = "Recived"
//            self.Lblamount.textColor = hexStringToUIColor(hex:"69B95C")
//        }
        // Configure the view for the selected state
    }
    func setData(Data:CoinDataModel){
        if(Data.type != "Received"){
            self.Lblamount.textColor = .StatusRed
            self.Lblamount.text = "사용함"
        }
        else{
            self.Lblamount.textColor = .StatusGreen
            self.Lblamount.text = "받음"
        }
      //  self.Lblamount.text = Data.type
        self.LblInfo.text = Data.amount!.description + " 포인트"
        self.LblDate.text = Data.created_at
    }
}
