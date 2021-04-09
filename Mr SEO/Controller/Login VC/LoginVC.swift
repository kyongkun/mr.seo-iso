//
//  LoginVC.swift
//  Mitten pets
//
//  Created by Mac on 07/01/21.
//

import UIKit
import IQKeyboardManagerSwift
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields


class LoginVC: UIViewController
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var LblNavigation: EMLabel!{
        didSet{
            LblNavigation.fontStyle = .Navigation
            LblNavigation.text = "Log In"
        }
    }

    @IBOutlet weak var txtEmail: MDCOutlinedTextField!
    @IBOutlet weak var BtnLogin: EMButton!{
        didSet{
            BtnLogin.btnType = .Submit
        }
    }
    @IBOutlet weak var BtnRememberme: EMButton!{
        didSet{
            BtnRememberme.btnType = .SmallGray
        }
    }
    @IBOutlet weak var BtnForgotPassword: EMButton!{
        didSet{
            BtnForgotPassword.btnType = .SmallBlue
        }
    }
//    @IBOutlet weak var BtnRemeberme: EMButton!{
//        didSet{
//            BtnForgotPassword.btnType = .SmallBlue
//        }
//    }
    @IBOutlet weak var txtPassword: MDCOutlinedTextField!
    // MARK: - Variables
    var isRememberMe = false
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.label.text = "Email"
        txtEmail.label.textColor = UIColor.AppTextFieldText
        txtEmail.placeHolderColor = UIColor.AppPlaceHolder
        txtEmail.outlineColor(for: .editing)
        txtEmail.setOutlineColor(UIColor.AppTextField, for: .editing)
        txtEmail.setOutlineColor(UIColor.AppTextField, for: .normal)
        self.txtEmail.keyboardType = UIKeyboardType.emailAddress

        txtEmail.sizeToFit()
        txtPassword.isSecureTextEntry = true
        txtPassword.label.text = "Password"
        txtPassword.label.textColor = UIColor.AppTextFieldText
        txtPassword.placeHolderColor = UIColor.AppPlaceHolder
        txtPassword.outlineColor(for: .editing)
        txtPassword.setOutlineColor(UIColor.AppTextField, for: .editing)
        txtPassword.setOutlineColor(UIColor.AppTextField, for: .normal)
        txtPassword.sizeToFit()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.BtnRememberme.setImage(#imageLiteral(resourceName: "ic_checkbox"), for: .normal)
        
        if (EstalimUser.shared.RememberMe != "false"){
            self.txtEmail.text = EstalimUser.shared.RememberMeEmail
            self.txtPassword.text = EstalimUser.shared.RememberMePassword
        }

//        self.txtEmail.text = "a@a.com"
//        self.txtPassword.text = "Abc@1234"
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnChangeLanguageAction(_ sender:UIButton){
        
    }
    @IBAction func BtnLoginAction(_ sender:UIButton){
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
        
        //appDelegate.setHome()

        WSLogin(Parameter: ["email":txtEmail.text!,"password":txtPassword.text!,"device_id":UIDevice.current.identifierForVendor!.uuidString,"device_type":"ios","push_token":appDelegate.deviceToken])
        //
    }
    @IBAction func BtnRememberMeAction(_ sender:UIButton){
        isRememberMe = !isRememberMe
        if(isRememberMe == true){
            sender.setImage(#imageLiteral(resourceName: "ic_checkbox_filled"), for: .normal)
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "ic_checkbox"), for: .normal)
        }
        
    }
    @IBAction func BtnForgotAction(_ sender:UIButton){
        self.pushTo("ForgotVC")
    }
    @IBAction func BtnRegisterAction(_ sender:UIButton){
        self.pushTo("RegisterVC")
    }
    @IBAction func btnFacebookLoginAction(_ sender: UIButton) {
        //self.GetFacebookData()
    }
    @IBAction func btnGoogleLoginAction(_ sender: UIButton) {
        
    }
    @IBAction func btnAppleLoginAction(_ sender: UIButton) {
       
       
    }
    
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    
    func WSLogin(Parameter:[String:String]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .Login, isAuth: false, WithParams: Parameter, Success: { (DataResponce, Status, Message) in
            if(Status == true){
                if(self.isRememberMe == true){
                    EstalimUser.shared.RememberMeEmail = self.txtEmail.text!
                    EstalimUser.shared.RememberMePassword = self.txtPassword.text!
                    EstalimUser.shared.save()
                }
                if let DataDict = DataResponce?.value(forKey: "data")  as? NSDictionary{
                    EstalimUser.shared.setLoginData(dict: DataDict, isRememberme: self.isRememberMe)
                        if #available(iOS 13.0, *) {
                            sceneDelegate.setHome()
                        } else {
                            appDelegate.setHome()
                            // Fallback on earlier versions
                        }
                }
            }
            else{
                if let errorMessage:String = Message{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
        }) { (DataResponce, Status, Message) in
            //
        }
    }
    func WSSocialLogin(Parameter:[String:String]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .Login, isAuth: true, WithParams: Parameter, Success: { (DataResponce, Status, Message) in
            if(Status == true){
                if let DataDict = DataResponce?.value(forKey: "data")  as? NSDictionary{
                    EstalimUser.shared.setData(dict: DataDict)
                    if #available(iOS 13.0, *) {
                        sceneDelegate.setHome()
                    } else {
                        appDelegate.setHome()
                        // Fallback on earlier versions
                    }                }
                //self.pushTo("HomeVC")
            }
            else{
                if let errorMessage:String = Message{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
        }) { (DataResponce, Status, Message) in
            //
        }
    }
}
