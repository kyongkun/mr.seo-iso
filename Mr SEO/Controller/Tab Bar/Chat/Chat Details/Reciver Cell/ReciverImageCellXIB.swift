//
//  ReciverImageCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 01/03/21.
//

import UIKit

class ReciverImageCellXIB: UITableViewCell {

    @IBOutlet weak var ViewMain:UIView!{
        didSet{
            DispatchQueue.main.async {
                CommonClass.sharedInstance.roundCorners(view: self.ViewMain, corners: [.topLeft,.topRight,.bottomRight], radius: 10)
            }
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
