//
//  EditProfileVC.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialTypographyScheme_BasicFontScheme
import SDWebImage
import DropDown

class EditProfileVC: UIViewController
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var ImgBankImage: UIImageView!
    

    @IBOutlet weak var txtEmail: MDCOutlinedTextField!{
        didSet{
            txtEmail.label.text = "이메일"
            txtEmail.label.textColor = UIColor.AppTextField
            txtEmail.placeHolderColor = UIColor.AppPlaceHolder
            txtEmail.outlineColor(for: .editing)
            txtEmail.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtEmail.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtEmail.sizeToFit()
        }
    }
    
    @IBOutlet weak var txtName: MDCOutlinedTextField!{
        didSet{
            txtName.label.text = "이름"
            txtName.label.textColor = UIColor.AppTextField
            txtName.placeHolderColor = UIColor.AppPlaceHolder
            txtName.outlineColor(for: .editing)
            txtName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtName.sizeToFit()
        }
    }
    @IBOutlet weak var txtNickName: MDCOutlinedTextField!{
        didSet{
            txtNickName.label.text = "닉네임"
            txtNickName.label.textColor = UIColor.AppTextField
            txtNickName.placeHolderColor = UIColor.AppPlaceHolder
            txtNickName.outlineColor(for: .editing)
            txtNickName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtNickName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtNickName.sizeToFit()
        }
    }
    @IBOutlet weak var txtPhone: MDCOutlinedTextField!{
        didSet{
            txtPhone.label.text = "전화번호"
            txtPhone.label.textColor = UIColor.AppTextField
            txtPhone.placeHolderColor = UIColor.AppPlaceHolder
            txtPhone.outlineColor(for: .editing)
            txtPhone.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtPhone.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtPhone.sizeToFit()
        }
    }
    
    @IBOutlet weak var txtBankName: MDCOutlinedTextField!{
        didSet{
            txtBankName.label.text = "은행이름"
            let eyeIcon = UIImageView(image: UIImage(named: "ic_dropdown"))
            txtBankName.trailingView = eyeIcon
            txtBankName.trailingViewMode = .always
            txtBankName.label.textColor = UIColor.AppTextField
            txtBankName.placeHolderColor = UIColor.AppPlaceHolder
            txtBankName.outlineColor(for: .editing)
            txtBankName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtBankName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtBankName.sizeToFit()
        }
    }
    @IBOutlet weak var txtAccountNumber: MDCOutlinedTextField!{
        didSet{
            txtAccountNumber.label.text = "계좌번호"
            txtAccountNumber.label.textColor = UIColor.AppTextField
            txtAccountNumber.placeHolderColor = UIColor.AppPlaceHolder
            txtAccountNumber.outlineColor(for: .editing)
            txtAccountNumber.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtAccountNumber.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtAccountNumber.sizeToFit()
        }
    }
    @IBOutlet weak var txtBankRegistrationImage: MDCOutlinedTextField!{
        didSet{
            txtBankRegistrationImage.label.text = "사업자 등록증 사본"
            txtBankRegistrationImage.label.textColor = UIColor.AppTextField
            txtBankRegistrationImage.placeHolderColor = UIColor.AppPlaceHolder
            txtBankRegistrationImage.outlineColor(for: .editing)
            txtBankRegistrationImage.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtBankRegistrationImage.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtBankRegistrationImage.sizeToFit()
            txtBankRegistrationImage.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
            LblNavigationTitle.text = "프로필 수정"
        }
    }
    @IBOutlet weak var BtnUpdate: EMButton!{
        didSet{
            BtnUpdate.btnType = .Submit
            BtnUpdate.setTitle("수정하기", for: .normal)
            BtnUpdate.setTitle("수정하기", for: .selected)
        }
    }

    // MARK: - Variables
    let dropDown = DropDown()
    var ArrBankList =  [BankListModel]()

    var BankImage:UIImage? = nil
    

    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(EstalimUser.shared.country_code)
        
        dropDown.anchorView = self.txtBankName
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtBankName.text = item
        }
        dropDown.width = self.txtBankName.frame.width-40
        dropDown.direction = .any
        dropDown.bottomOffset = CGPoint(x: 20, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        self.SetData()
    }
    // MARK: - Functions
    func SetData(){
        
        self.txtName.text = EstalimUser.shared.name
        self.txtEmail.text = EstalimUser.shared.email
        self.txtPhone.text = EstalimUser.shared.mobile
        self.txtBankName.text = EstalimUser.shared.bank_name
        self.txtNickName.text = EstalimUser.shared.nick_name
        self.txtAccountNumber.text = EstalimUser.shared.account_number
        self.ImgBankImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.ImgBankImage.sd_setImage(with: URL(string:EstalimUser.shared.bank_image), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
        
    }
    // MARK: - UIButton Actions
    @IBAction func BtnIOpenDropDownAction(_ sender:UIButton){
        if self.ArrBankList.count>0{
            self.dropDown.show()
        }
        else{
            self.WSGetBankName(Parameter: [:])
        }
        
    }
    @IBAction func BtnChangeImageAction(_ sender:UIButton){
        ImagePickerManager().pickImage(self){ image in
                self.BankImage = image
            //self.ImgUser.image = image
//            /self.txtBankRegistrationImage.text = "Image"
        }
    }
    @IBAction func BtnBankImageAction(_ sender:UIButton){
        ImagePickerManager().pickImage(self){ image in
            self.ImgBankImage.image = image
        }
    }


    @IBAction func BtnUpdateProfileAction(_ sender:UIButton){
        //self.BankImage = self.ImgUser.image
        guard let text = txtEmail.text, !text.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.EmailNameMissing)
            return
        }
        guard let validEmail = txtEmail.text,  !validEmail.isValidEmail() == false else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidEmail)
            return
        }
        guard let Nametext = txtName.text, !Nametext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.NameMissing)
            return
        }
        guard let NickNametext = txtNickName.text, !NickNametext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.NickNameMissing)
            return
        }
        guard let Phonetext = txtNickName.text, !Phonetext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.MobileMissing)
            return
        }
        guard let BankName = txtBankName.text, !BankName.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.BankNameMissing)
            return
        }
        guard let AcountNumber = txtAccountNumber.text, !AcountNumber.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.AccountNoMissing)
            return
        }
       
        if(self.ImgBankImage.image != nil){
            self.WSUpdateChangeBankImage(Parameter: ["email":self.txtEmail.text!,"name":self.txtName.text!,"nick_name":self.txtNickName.text!,"country_code":"+82","device_id":UIDevice.current.identifierForVendor!.uuidString,"push_token":"","mobile":self.txtPhone.text!,"device_type":"ios","bank_name":self.txtBankName.text!,"account_number":self.txtAccountNumber.text!], bank_image: self.ImgBankImage.image!)
            
        }
        else{
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.BankImageMissing)
        }
        
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSGetBankName(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callGetAPI(WithType: .GetBankName, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
            if Success == true{
                if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrBankList.removeAll()
                    self.ArrBankList = BankListModel.modelsFromDictionaryArray(array: Language)
                    if(self.ArrBankList.count>0){
                        self.txtBankName.text = self.ArrBankList.first?.name
                        self.dropDown.dataSource = self.ArrBankList.map({$0.name!})
                        self.dropDown.show()
                    }
                    else{
                    }
                }
            }
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSUpdateProfile(Parameter:[String:String],bank_image:UIImage) -> Void {
        ServiceManager.shared.callAPIWithImage(WithType: .UpdateProfile, imageUpload: bank_image, imageName: "profile_image", WithParams: Parameter) { (DataResponce, Status, Message) in
            if(Status == true){
                self.popTo()
            }
            else{
                if let errorMessage:String = Message{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
        } Failure: { (DataResponce, Status, Message) in
            
        }
    }
    func WSUpdateChangeBankImage(Parameter:[String:String],bank_image:UIImage) -> Void {
        ServiceManager.shared.callAPIWithMultipleImage(WithType: .UpdateProfile, imageUpload: [self.ImgBankImage.image!,self.ImgBankImage.image!], WithParams: Parameter) { (DataResponce, Status, Message) in
            if(Status == true){
                if let DataDict = DataResponce?.value(forKey: "data")  as? NSDictionary{
                    EstalimUser.shared.setData(dict: DataDict)
                    self.popTo()

                }

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
