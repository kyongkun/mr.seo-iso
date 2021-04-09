//
//  NoticeRow.swift
//  Mr SEO
//
//  Created by Mac on 20/03/21.
//

import UIKit

class NoticeRow: UITableViewCell {
    @IBOutlet var toggleButton: UIButton!
    @IBOutlet var ImgProduct: UIImageView!
    @IBOutlet var LblDescription: UILabel!
    @IBOutlet var LblTitle: UILabel!
    @IBOutlet var LblTIme: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
