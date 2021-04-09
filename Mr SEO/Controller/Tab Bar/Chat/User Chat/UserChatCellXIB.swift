//
//  UserChatCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit

class UserChatCellXIB: UITableViewCell {
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblMessage: UILabel!
    @IBOutlet weak var LblTime : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(Data:ChatDataModel){
        if(Data.sender_user?.id?.description != EstalimUser.shared.id){
            self.LblName.text = Data.sender_user?.name
        }
        else{
            self.LblName.text = Data.receiver_user?.name
        }
        self.LblMessage.text = Data.message_latest?.message
        self.LblTime.text = timeAgoSinceDate1(getDateFromString(date: Data.message_latest?.created_at ?? ""))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
