//
//  ProfileVC.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var LblPriceInfo: UILabel!{
        didSet{
            LblPriceInfo.text = "I have " + EstalimUser.shared.coin  + " Coins for use"
        }
    }
    @IBOutlet weak var Lblamount: UILabel!{
        didSet{
            Lblamount.text =  EstalimUser.shared.coin  + " Coins"
        }
    }
    @IBOutlet weak var ImgUser: UIImageView!
    @IBOutlet weak var ImgBankImage: UIImageView!
    
    // MARK: - Variables
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
        }
    }
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblInfo: UILabel!
    @IBOutlet weak var LblEmail : UILabel!
    @IBOutlet weak var LblPhone  : UILabel!
    @IBOutlet weak var LblBankName: UILabel!
    @IBOutlet weak var LblNickName: UILabel!
    @IBOutlet weak var LblAccountNumber: UILabel!
    @IBOutlet weak var LblBankAccount: UILabel!
    @IBOutlet weak var PushSwitch: UISwitch!{
        didSet{
            PushSwitch.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
        }
    }
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setData()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
    }
    // MARK: - Functions
    
    @objc func switchValueDidChange(sender:UISwitch!) {
        print(sender.isOn)
        if sender.isOn == true{
            self.WSUpdateNotification(Parameter: ["status":"1"])
        }
        else{
            self.WSUpdateNotification(Parameter: ["status":"0"])
        }
        
    }
    func setData(){
        self.LblName.text = EstalimUser.shared.name
        if(EstalimUser.shared.is_notify == "0"){
            self.PushSwitch.setOn(false, animated: true)
        }
        else{
            self.PushSwitch.setOn(true, animated: true)
        }
        
        
    }
    // MARK: - UIButton Actions
    @IBAction func BtnPointsAction(_ sender:UIButton){
        let vc = storyBoards.MyContent.instantiateViewController(withIdentifier: "CoinsVC") as? CoinsVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    //Public Notice
    @IBAction func BtnPublicNoticeAction(_ sender:UIButton){
        self.pushTo("PublicNoticeVC")
    }
    @IBAction func BtnContactUsAction(_ sender:UIButton){
        self.pushTo("SupportVC")
    }
    @IBAction func BtnEditProfileAction(_ sender:UIButton){
        self.pushTo("EditProfileVC")
    }
    @IBAction func BtnChangePasswordAction(_ sender:UIButton){
        self.pushTo("ChangePasswordVC")
        
    }
    @IBAction func BtnProfileDetailsAction(_ sender:UIButton){
        self.pushTo("ProfileDetailsVC")
        
    }
    @IBAction func BtnLogOutAction(_ sender:UIButton){
       // self.pushTo("ProfileDetailsVC")
        
        showAlertWithTitleFromVC(vc: self, title: Constant.APP_NAME, andMessage: AlertMessage.logoutMessage, buttons: ["NO","YES"]) { (i) in
            if(i == 1){
                self.WSLogout(Parameter: [:])
                

            }
        }
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSLogout(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callGetAPI(WithType: .Logout, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
            if Success == true{
                EstalimUser.shared.clear()
                if #available(iOS 13.0, *) {
                    sceneDelegate.makeLoginAsRoot()
                } else {
                    appDelegate.makeLoginAsRoot()
                    // Fallback on earlier versions
                }
            }
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSUpdateNotification(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .UpdateNotification, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let DataDict = ResponseDict?.value(forKey: "data")  as? NSDictionary{
                    EstalimUser.shared.setData(dict: DataDict)
                }
                if let errorMessage:String = ResponseDict?.value(forKey: "message") as? String{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSUpdateProfile(Parameter:[String:String],bank_image:UIImage) -> Void {
        ServiceManager.shared.callAPIWithImage(WithType: .UpdateProfile, imageUpload: bank_image, imageName: "image", WithParams: Parameter) { (DataResponce, Status, Message) in
            if(Status == true){
            }
            else{
                if let errorMessage:String = Message{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
        } Failure: { (DataResponce, Status, Message) in
            
        }
    }
    
}
