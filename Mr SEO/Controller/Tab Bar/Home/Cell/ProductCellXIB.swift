//
//  ProductCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit
import SDWebImage

class ProductCellXIB: UITableViewCell {
    @IBOutlet weak var LblHeader:UILabel!
    @IBOutlet weak var LblUserName:UILabel!
    @IBOutlet weak var ViewAdvertise:UIView!{
        didSet{
            ViewAdvertise.isHidden = true
        }
    }

    @IBOutlet weak var ImgAdv:UIImageView!
    @IBOutlet weak var LblCoins1:UILabel!
    @IBOutlet weak var LblCoins2:UILabel!
    @IBOutlet weak var ViewBg:UIView!
    @IBOutlet weak var BtnAdver:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(Data:PostModel){
        self.LblHeader.text = Data.title
        self.ViewBg.backgroundColor = hexStringToUIColor(hex: Data.color! )//?? "CECECE"
        self.LblUserName.text = Data.email
        self.LblCoins1.text = String(Data.register_point! - Data.helper_count!)
        self.LblCoins2.text = " /" + Data.register_point!.description
        if(Data.HasAdvertise == true){
            self.ViewAdvertise.isHidden = false
            self.ImgAdv.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.ImgAdv.sd_setImage(with: URL(string:Data.advertisements?.image ?? ""),placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
            self.layoutIfNeeded()
        }
        else{
            self.ViewAdvertise.isHidden = true
        }
    }
    func setMyContentData(Data:PostModel){
        self.LblHeader.text = Data.title?.capitalized
        self.ViewBg.backgroundColor = hexStringToUIColor(hex: Data.color ?? "CECECE")
        self.LblUserName.text = Data.email
        self.LblCoins1.text = String(Data.register_point! - Data.helper_count!)
        self.LblCoins2.text = Data.helper_count?.description

    }
}
