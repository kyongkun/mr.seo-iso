//
//  MyContentCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 23/03/21.
//

import UIKit

class MyContentCellXIB: UITableViewCell {
    @IBOutlet weak var LblCategoryName:UILabel!
    @IBOutlet weak var LblKey1:UILabel!
    @IBOutlet weak var LblKey2:UILabel!
    @IBOutlet weak var LblValue1:UILabel!
    @IBOutlet weak var LblValue2:UILabel!
    
    @IBOutlet weak var BtnGoToChat:EMButton!{
        didSet{
            BtnGoToChat.btnType = .ChatButton
            BtnGoToChat.isHidden = true
        }
    }
    @IBOutlet weak var LblStatus:UILabel!{
        didSet{
            LblStatus.isHidden = true
        }
    }
    
    @IBOutlet weak var LblCoins1:UILabel!
    @IBOutlet weak var LblRemeber:UILabel!

    @IBOutlet weak var SwitchProduct:UISwitch!{
        didSet{
            SwitchProduct.isHidden = true
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
    func setHelpData(Data:MyPostModel){
        self.LblCategoryName.text = Data.title
        if(Data.category_id == 4){
            self.LblKey1.text = "제목"
            self.LblValue1.text = Data.title
            
        }
        else{
            self.LblKey1.text = "키워드"
            self.LblValue1.text = Data.keyword
        }
        self.LblKey2.text = "이름"
        self.LblValue2.text = Data.name
        self.LblRemeber.alpha = 0
        self.LblCoins1.alpha = 0
    }
    func setData(Data:MyPostModel){
        self.LblCategoryName.text = Data.title
        if(Data.category_id == 4){
            self.LblKey1.text = "제목"
            self.LblValue1.text = Data.cafe_title
            
        }
        else{
            self.LblKey1.text = "키워드"
            self.LblValue1.text = Data.keyword
        }
        self.LblKey2.text = "이름"
        self.LblValue2.text = Data.name
        self.LblRemeber.alpha = 1
        self.LblCoins1.alpha = 1

        self.LblCoins1.text = String(Data.register_point!-Data.helper_count!) + "/" + Data.register_point!.description
        
    }
    
}
