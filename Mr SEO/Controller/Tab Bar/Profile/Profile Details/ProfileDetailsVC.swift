//
//  ProfileDetailsVC.swift
//  Mr SEO
//
//  Created by Mac on 17/03/21.
//

import UIKit
import SDWebImage

class ProfileDetailsVC: UIViewController {
    // MARK: - UIControlers Outlate
    //@IBOutlet weak var ImgUser: UIImageView!
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

    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setData()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
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

        self.LblEmail.text = EstalimUser.shared.email
        self.LblPhone.text = EstalimUser.shared.mobile
        self.LblBankName.text = EstalimUser.shared.bank_name
        self.LblNickName.text = EstalimUser.shared.nick_name
        self.LblAccountNumber.text = EstalimUser.shared.account_number
        self.ImgBankImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.ImgBankImage.sd_setImage(with: URL(string:EstalimUser.shared.bank_image), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
        self.LblName.text = EstalimUser.shared.name
        self.LblAccountNumber.text = EstalimUser.shared.account_number
        self.LblBankName.text = EstalimUser.shared.bank_name

    }
    // MARK: - UIButton Actions
    @IBAction func BtnContactUsAction(_ sender:UIButton){
        self.pushTo("SupportVC")
        
    }
    @IBAction func BtnEditProfileAction(_ sender:UIButton){
        self.pushTo("EditProfileVC")
    }
    @IBAction func BtnChangePasswordAction(_ sender:UIButton){
        self.pushTo("ChangePasswordVC")
        
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.popTo()
    }
    @IBAction func BtnLogOutAction(_ sender:UIButton){

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
