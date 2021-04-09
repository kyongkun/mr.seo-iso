//
//  RegisterVC.swift
//  Mitten pets
//
//  Created by Mac on 11/01/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialTypographyScheme_BasicFontScheme
import DropDown
import Firebase


class RegisterVC: UIViewController,UITextFieldDelegate
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var ImgUser: UIImageView!{
        didSet{
            ImgUser.image = #imageLiteral(resourceName: "ic_placeholder")
            ImgUser.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet weak var ImgviewBank: UIImageView!
    {
        didSet{
            ImgviewBank.image = #imageLiteral(resourceName: "ic_placeholder")
            ImgviewBank.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var LblNavigation: EMLabel!{
        didSet{
            LblNavigation.fontStyle = .Navigation
            LblNavigation.text = "Sign Up"
        }
    }
    @IBOutlet weak var BtnSignup: EMButton!{
        didSet{
            BtnSignup.btnType = .Submit
            BtnSignup.setTitle("Sign Up", for: .normal)
            BtnSignup.setTitle("Sign Up", for: .selected)
        }
    }
    @IBOutlet weak var txtEmail: MDCOutlinedTextField!{
        didSet{
            txtEmail.label.text = "Email"
            txtEmail.label.textColor = UIColor.AppTextField
            txtEmail.placeHolderColor = UIColor.AppPlaceHolder
            txtEmail.outlineColor(for: .editing)
            txtEmail.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtEmail.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtEmail.keyboardType  = .emailAddress
            txtEmail.sizeToFit()
            txtEmail.delegate = self
        }
    }
    @IBOutlet weak var txtPassword: MDCOutlinedTextField!{
        didSet{
            
            txtPassword.label.text = "Password"
            txtPassword.isSecureTextEntry = true
            txtPassword.label.textColor = UIColor.AppTextField
            txtPassword.placeHolderColor = UIColor.AppPlaceHolder
            txtPassword.outlineColor(for: .editing)
            txtPassword.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtPassword.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtPassword.sizeToFit()
            txtPassword.delegate = self
        }
    }
    
    @IBOutlet weak var txtConfirmPassword: MDCOutlinedTextField!{
        didSet{
            
            txtConfirmPassword.label.text = "Password"
            txtConfirmPassword.label.text = "Confirm Password"
            txtConfirmPassword.label.textColor = UIColor.AppTextField
            txtConfirmPassword.placeHolderColor = UIColor.AppPlaceHolder
            txtConfirmPassword.outlineColor(for: .editing)
            txtConfirmPassword.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtConfirmPassword.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtConfirmPassword.sizeToFit()
            txtConfirmPassword.delegate = self

        }
    }
    @IBOutlet weak var txtName: MDCOutlinedTextField!{
        didSet{
            txtName.keyboardType = .default
            txtName.label.text = "Name"
            txtName.label.textColor = UIColor.AppTextField
            txtName.placeHolderColor = UIColor.AppPlaceHolder
            txtName.outlineColor(for: .editing)
            txtName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtName.sizeToFit()
            txtName.delegate = self

        }
    }
    @IBOutlet weak var txtNickName: MDCOutlinedTextField!{
        didSet{
            txtNickName.keyboardType = .default
            txtNickName.label.text = "Nick Name"
            txtNickName.label.textColor = UIColor.AppTextField
            txtNickName.placeHolderColor = UIColor.AppPlaceHolder
            txtNickName.outlineColor(for: .editing)
            txtNickName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtNickName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtNickName.sizeToFit()
            txtNickName.delegate = self

        }
    }
    @IBOutlet weak var txtPhone: MDCOutlinedTextField!{
        didSet{
            txtNickName.keyboardType = .phonePad

            txtPhone.label.text = "Phone"
            txtPhone.label.textColor = UIColor.AppTextField
            txtPhone.placeHolderColor = UIColor.AppPlaceHolder
            txtPhone.outlineColor(for: .editing)
            txtPhone.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtPhone.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtPhone.sizeToFit()
            txtPhone.delegate = self

        }
    }
    
    @IBOutlet weak var txtBankName: MDCOutlinedTextField!{
        didSet{
            txtBankName.label.text = "Bank Name"
            let eyeIcon = UIImageView(image: UIImage(named: "ic_dropdown"))
            txtBankName.trailingView = eyeIcon
            txtBankName.trailingViewMode = .always
            txtBankName.label.textColor = UIColor.AppTextField
            txtBankName.placeHolderColor = UIColor.AppPlaceHolder
            txtBankName.outlineColor(for: .editing)
            txtBankName.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtBankName.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtBankName.sizeToFit()
            txtBankName.delegate = self

        }
    }
    @IBOutlet weak var txtAccountNumber: MDCOutlinedTextField!{
        didSet{
            txtAccountNumber.label.text = "Account Number"
            txtAccountNumber.label.textColor = UIColor.AppTextField
            txtAccountNumber.placeHolderColor = UIColor.AppPlaceHolder
            txtAccountNumber.outlineColor(for: .editing)
            txtAccountNumber.setOutlineColor(UIColor.AppTextField, for: .editing)
            txtAccountNumber.setOutlineColor(UIColor.AppTextField, for: .normal)
            txtAccountNumber.sizeToFit()
            txtAccountNumber.delegate = self

        }
    }
    
//    @IBOutlet weak var txtInfo: MDCOutlinedTextArea!{
//        didSet{
//            txtInfo.label.text = "Info"
//            txtInfo.textView.text = "아이디는 실사용중인 네이버 아이디를 입력해주시기 바랍니다. 회원가입 이후관리자승인까지 1~2영업일이 소요될 수 있습니다. 관리자 승인 후 로그인 부탁드립니다."
//            txtInfo.layer.frame.size.height = 100
//            txtInfo.isUserInteractionEnabled = false
//            txtInfo.label.textColor = UIColor.AppTextField
//            txtInfo.placeholderColor = UIColor.AppPlaceHolder
//            txtInfo.outlineColor(for: .editing)
//            txtInfo.setOutlineColor(UIColor.AppTextField, for: .editing)
//            txtInfo.setOutlineColor(UIColor.AppTextField, for: .normal)
//            txtInfo.sizeToFit()
//        }
//    }
    @IBOutlet weak var BtnAgree: UIButton!

    // MARK: - Variables
    var isRememberMe = true
    let dropDown = DropDown()
    var ArrBankList =  [BankListModel]()
    var BankImage:UIImage? = nil
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.txtEmail.keyboardType = UIKeyboardType.emailAddress
        txtName.keyboardType = .default
        txtNickName.keyboardType = .default

        txtNickName.delegate = self
        txtName.delegate = self
        txtEmail.delegate = self
        txtBankName.delegate = self
        txtAccountNumber.delegate = self
        txtBankName.delegate = self
        txtName.autocorrectionType = .no
        txtNickName.autocorrectionType = .no
        txtEmail.autocorrectionType = .no
        txtBankName.autocorrectionType = .no
        txtAccountNumber.autocorrectionType = .no
        txtBankName.isUserInteractionEnabled = true
        dropDown.anchorView = self.txtBankName
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtBankName.text = item
        }
        self.BtnIAgreeTandCAction(self.BtnAgree)
        dropDown.width = self.txtBankName.frame.width
        dropDown.direction = .any
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.WSGetBankName(Parameter: [:])
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnIOpenDropDownAction(_ sender:UIButton){
        if self.ArrBankList.count>0{
            self.dropDown.show()
        }
        
    }
    
    @IBAction func BtnIAgreeTandCAction(_ sender:UIButton){
        isRememberMe = !isRememberMe

        if(isRememberMe == true){
            sender.setImage(#imageLiteral(resourceName: "ic_checkbox_filled"), for: .normal)
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "ic_checkbox"), for: .normal)
        }

        
    }
    @IBAction func BtnTandCAction(_ sender:UIButton){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionVC") as! TermsAndConditionVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(vc, animated: true)
    }
    @IBAction func BtnChoosebankImageAction(_ sender:UIButton){
        ImagePickerManager().pickImage(self){ image in
            self.BankImage = image
            self.ImgviewBank.image = image
        }
    }
    @IBAction func BtnChooseUserImageAction(_ sender:UIButton){
        ImagePickerManager().pickImage(self){ image in
            self.ImgUser.image = image
        }
    }

    @IBAction func BtnRegisterAction(_ sender:UIButton){
        
        
        


        guard let text = txtEmail.text, !text.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.EmailNameMissing)
            return
        }
        guard let validEmail = txtEmail.text,  !validEmail.isValidEmail() == false else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidEmail)
            return
        }
        guard let ptext = txtPassword.text, !ptext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.PasswordMissing)
            return
        }
        guard ptext.length > 7 else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.PasswordLenghtMissing)
            return
        }
//        guard let isValidPassword = txtPassword.text, !isValidPassword.isValidPassword() == false else {
//            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidPasswordMissing)
//            return
//        }
        guard let cptext = txtConfirmPassword.text, !cptext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ConfirmPasswordMissing)
            return
        }
        guard cptext.length > 7 else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ConfirmPasswordLenghtMissing)
            return
        }
//        guard let isValidCPassword = txtPassword.text, !isValidCPassword.isValidPassword() == false else {
//            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidPasswordMissing)
//            return
//        }
        guard  ptext == cptext else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.PasswordNotMatch)
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
        guard let Phonetext = txtPhone.text, !Phonetext.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.MobileMissing)
            return
        }
        guard Phonetext.isValidMobileNumber() else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidMobile)
            return
        }
        guard Phonetext.prefix(3) != "000" else {
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.ValidMobile)
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
//        guard let Info = txtInfo.textView.text, !Info.isEmpty else {
//            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.InfoMissing)
//            return
//        }
        if(self.BankImage != nil){
            if(self.isRememberMe == true){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerificationVC") as! OtpVerificationVC
            vc.bankimg = self.BankImage!
            vc.userimg = self.ImgUser.image!
                vc.datadict = ["email":self.txtEmail.text!,"password":self.txtPassword.text!,"name":self.txtName.text!,"confirm_password":self.txtConfirmPassword.text!,"nick_name":self.txtNickName.text!,"country_code":"+82","device_id":UIDevice.current.identifierForVendor!.uuidString,"push_token":"","mobile":self.txtPhone.text!,"device_type":"ios","bank_name":self.txtBankName.text!,"account_number":self.txtAccountNumber.text!]//,"info":self.txtInfo.textView.text!
            self.navigationController?.pushViewController(vc, animated: true)

            }
            else{
                showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.AgreeTermsAndCondition)
            }
        }
        else{
            showAlertWithTitleFromVC(vc: self, andMessage: AlertMessage.BankImageMissing)
        }
        
    }
    
    @IBAction func BtnBackToLoginAction(_ sender:UIButton){
        self.popTo()
    }
    
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.txtBankName){
            DispatchQueue.main.async {
                textField.resignFirstResponder()
                self.dropDown.show()
            }

        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
         if(textField == self.txtPhone) || textField == self.txtAccountNumber{
            DispatchQueue.main.async {
                textField.resignFirstResponder()
                self.dropDown.hide()
            }
        }
         else{
            
         }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if (textField == self.txtPhone ||  textField == self.txtAccountNumber){
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    
    func WSGetBankName(Parameter:[String:Any]) -> Void {
            ServiceManager.shared.callGetAPI(WithType: .GetBankName, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
                if Success == true{
                    if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                        self.ArrBankList.removeAll()
                        self.ArrBankList = BankListModel.modelsFromDictionaryArray(array: Language)
                        if(self.ArrBankList.count>0){
                            //self.txtBankName.text = self.ArrBankList.first?.name
                            self.dropDown.dataSource = self.ArrBankList.map({$0.name!})
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
}

