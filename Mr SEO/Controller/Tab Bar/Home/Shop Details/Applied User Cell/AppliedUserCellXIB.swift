//
//  AppliedUserCellXIB.swift
//  Mr SEO
//
//  Created by Mac on 22/03/21.
//

import UIKit

class AppliedUserCellXIB: UITableViewCell {
    @IBOutlet weak var MainView:UIView!{
        didSet{
            DispatchQueue.main.async {
//                self.MainView.layer.cornerRadius = 10
//                self.MainView.shadow = true
                //CommonClass.sharedInstance.shadowWithCorner(view: self.MainView, corners: .allCorners, radius: 10, borderColor: .LineColor)
                //self.MainView.shadow = true
            }
            
        }
    }
    @IBOutlet weak var ViewCashSent:UIView!
    @IBOutlet weak var ViewViewProof:UIView!
    @IBOutlet weak var ViewFinished:UIView!
    @IBOutlet weak var BtnCashSent:UIButton!
    @IBOutlet weak var BtnViewProof:UIButton!
    @IBOutlet weak var BtnFinished:UIButton!
    @IBOutlet weak var BtnGotoChat:UIButton!
    @IBOutlet weak var LblEmail:UILabel!
    @IBOutlet weak var LblAccountNO:UILabel!
    @IBOutlet weak var LblBankName:UILabel!
    @IBOutlet weak var LblIsUplodedIMage:UILabel!
    @IBOutlet weak var ImgFirst:UIImageView!
    @IBOutlet weak var ImgSecond:UIImageView!
    @IBOutlet weak var stackView:UIStackView!
    
    @IBOutlet weak var ViewImage:UIView!

    @IBOutlet weak var BtnConfirm:EMButton!{
        didSet{
            BtnConfirm.btnType = .Submit
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
    
    func setData(Data:HelperModel){
        self.LblEmail.text = Data.email
        self.LblBankName.text = Data.bank_name
        self.LblAccountNO.text = Data.account_number?.description
        self.LblIsUplodedIMage.text = Data.proof_upload
        
        if(Data.proof_upload?.lowercased() == "no"){
            self.ViewImage.isHidden = true
            self.stackView.layoutIfNeeded()
        }
        else{
           //self.ViewImage.isHidden = false
            //self.stackView.layoutIfNeeded()
//            if(Data.IsImageDisable == true){
            self.ViewImage.isHidden = Data.IsImageDisable!
                self.stackView.layoutIfNeeded()
//            }
//            else{
//                self.ViewImage.isHidden = false
//
//                self.stackView.layoutIfNeeded()
//            }
            
        }
        
        
        switch Data.status {
        case "request_completed":
            self.ViewCashSent.backgroundColor = .StatusRed
            self.ViewFinished.backgroundColor = .StatusRed
            self.ViewViewProof.backgroundColor = .StatusRed
            self.BtnCashSent.isUserInteractionEnabled = true
            self.BtnConfirm.isUserInteractionEnabled = true
            self.BtnFinished.isUserInteractionEnabled = false
            self.BtnViewProof.isUserInteractionEnabled = true
            break
        case "cash_sent":
            self.ViewCashSent.backgroundColor = .StatusBlue
            self.ViewFinished.backgroundColor = .StatusRed
            self.ViewViewProof.backgroundColor = .StatusRed
            self.BtnCashSent.isUserInteractionEnabled = false
            self.BtnConfirm.isUserInteractionEnabled = true
            self.BtnFinished.isUserInteractionEnabled = true
            self.BtnViewProof.isUserInteractionEnabled = true
            if(Data.IsImageDisable == false){
                self.ViewViewProof.backgroundColor = .StatusGreen
            }
            else{
                self.ViewViewProof.backgroundColor = .StatusRed
            }
            
            break
        case "checking_proofs":
            self.ViewCashSent.backgroundColor = .StatusBlue
            self.ViewFinished.backgroundColor = .StatusRed
            self.ViewViewProof.backgroundColor = .StatusRed
            self.BtnCashSent.isUserInteractionEnabled = false
            self.BtnConfirm.isUserInteractionEnabled = true
            self.BtnFinished.isUserInteractionEnabled = true
            self.BtnViewProof.isUserInteractionEnabled = true
            
            break
        case "proofs_checked":
            self.ViewCashSent.backgroundColor = .StatusBlue
            self.ViewFinished.backgroundColor = .StatusRed
            self.ViewViewProof.backgroundColor = .StatusGreen
            self.BtnCashSent.isUserInteractionEnabled = false
            self.BtnConfirm.isUserInteractionEnabled = false
            self.BtnFinished.isUserInteractionEnabled = true
            self.BtnViewProof.isUserInteractionEnabled = true
            break
            
        case "finished":
            self.ViewCashSent.backgroundColor = .StatusBlue
            self.ViewFinished.backgroundColor = .StatusGreen
            self.ViewViewProof.backgroundColor = .StatusBlue
            self.BtnCashSent.isUserInteractionEnabled = false
            self.BtnConfirm.isUserInteractionEnabled = false
            self.BtnFinished.isUserInteractionEnabled = false
            self.BtnViewProof.isUserInteractionEnabled = true
            break

        default:
            break
        }
        
    }
    
}
