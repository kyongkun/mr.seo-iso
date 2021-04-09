//
//  AppliedForUserCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 28/03/21.
//

import UIKit

class AppliedForUserCellXIB: UITableViewCell {

    @IBOutlet weak var BtnApplyforHelp:EMButton!{
        didSet{
            BtnApplyforHelp.btnType = .Submit
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
